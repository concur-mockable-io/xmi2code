<?php
class Deployer
{
    private $filename;
    private $breadcrumbs = array();
    private $_tagStack = array();

    public function __construct( $filename )
    {
        $this->filename = $filename;
    }

    public function deploy()
    {
        $xml_parser = xml_parser_create();
        xml_set_element_handler( $xml_parser, array($this,'start'), array($this,'end') );
        xml_set_character_data_handler($xml_parser, array($this,'put'));
        xml_parse( $xml_parser, file_get_contents($this->filename));
    }

    private function start($parser, $tag, $attrs = null )
    {
        array_push($this->_tagStack,$tag);

        switch($tag)
        {
            case 'FOLDER' : $this->visitFolder($attrs);break;
            case 'FILE'   : $this->visitFile($attrs);break;
        }
    }

    private function end( $parser, $tag)
    {
        array_pop($this->_tagStack);
        array_pop($this->breadcrumbs);
    }

    private function visitFolder($attrs)
    {
        if( empty($attrs['NAME']) )
        {
            throw new Exception('aucun nom fourni pour un dossier');
        }
        $name = $attrs['NAME'];

        array_push( $this->breadcrumbs, $name);

        $pathname = implode("/",$this->breadcrumbs);

        if( !is_dir( $pathname ) )
            mkdir( $pathname );
    }

    private function visitFile($attrs)
    {
        if( empty($attrs['NAME']) )
        {
            throw new Exception('aucun nom fourni pour un dossier');
        }
        $name = $attrs['NAME'];

        array_push( $this->breadcrumbs, $name);
        echo implode("/",$this->breadcrumbs)."\n";
    }

    private function put($parser,$cdata)
    {
        $tag = array_pop( $this->_tagStack );
        switch( $tag )
        {
            case 'FILE' :file_put_contents(implode("/",$this->breadcrumbs), $cdata);
        }
        array_push( $this->_tagStack, $tag);
    }
}

$d = new Deployer('sample-psm.xml');
$d->deploy();
