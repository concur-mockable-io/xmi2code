XMI-to-PHP XSL stylesheet [![Build Status](https://secure.travis-ci.org/charlycoste/xmi2code.png)](http://travis-ci.org/charlycoste/xmi2code)
=========================

Beware! This is just a test and developpement branch.
It is not supposed to work for now.

How to try it?
--------------

For exemple: These are different ways to display a PHP code generated from XMI :

In command line With xsltproc :

    $ xsltproc php.xsl sample.xmi

With php :

    $xml = new DOMDocument;
    $xml->load('sample.xmi');
    
    $xsl = new DOMDocument;
    $xsl->load('php.xsl');
    
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);
    echo $proc->transformToXML($xml);

With Java :

    import javax.xml.transform.stream.*;
    import javax.xml.transform.*;

    class XSLT {

      public static void main(String args[]){
        String xslt="php.xsl";
        String xml ="sample.xmi";
        try{
          TransformerFactory tFactory = TransformerFactory.newInstance();

          Transformer transformer = 
		    tFactory.newTransformer(new StreamSource(xslt));

          transformer.transform(new StreamSource(xml), 
			        new StreamResult(System.out));

        }
        catch (Exception e){
          e.printStackTrace();
        }
      }
    }


Copyright and license
---------------------

[![GNU Affero General Public License](http://www.gnu.org/graphics/agplv3-155x51.png)](http://www.gnu.org/licenses/agpl-3.0.html)

Copyright (C) 2012-2014 Synap System EURL

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
