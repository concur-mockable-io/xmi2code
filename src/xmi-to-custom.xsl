<?xml version="1.0"?>
<!-- 
    Copyright (c) 2010-2012 Charles-Edouard COSTE

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:uml="http://schema.omg.org/spec/UML/2.1"
                xmlns:xmi="http://schema.omg.org/spec/XMI/2.1">

<xsl:output method="xml" encoding="utf-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:key name="element" match="packagedElement" use="@xmi:id"/>

<xsl:template match="/">
<xsl:apply-templates select="./*" />
</xsl:template>

<xsl:template match="uml:Model">
<model>
<xsl:apply-templates select="packagedElement[@xmi:type='uml:Package']" />
</model>
</xsl:template>

<!-- Package template - START -->
<xsl:template match="packagedElement[@xmi:type='uml:Package']">
  <package>
    <xsl:attribute name="name">
      <xsl:value-of select="@name" />
    </xsl:attribute>
    <xsl:apply-templates select="packagedElement[@xmi:type='uml:Class']" />
    <xsl:apply-templates select="packagedElement[@xmi:type='uml:Package']" />
  </package>
</xsl:template>
<!-- Package template - END -->

<!-- Class template - START -->
<xsl:template match="packagedElement[@xmi:type='uml:Class']">
  <class>
    <xsl:attribute name="name">
      <xsl:value-of select="@name" />
    </xsl:attribute>
    <xsl:if test="@isAbstract='true'">
      <xsl:attribute name="abstract">
        <xsl:text>true</xsl:text>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates select="ownedAttribute" />
    <xsl:apply-templates select="ownedOperation" />
  </class>
</xsl:template>
<!-- Class template - END -->

<!-- Class attributes template - START -->
<xsl:template match="ownedAttribute[@xmi:type='uml:Property']">
<attribute>
  <xsl:attribute name="name">
    <xsl:value-of select="@name" />
  </xsl:attribute>
  <xsl:attribute name="visibility">
    <xsl:value-of select="@visibility" />
  </xsl:attribute>
</attribute>
</xsl:template>
<!-- Class attributes template - END --> 

<!-- Class operations template - START -->
<xsl:template match="ownedOperation[@xmi:type='uml:Operation']">
<method>
  <xsl:attribute name="name">
    <xsl:value-of select="@name" />
  </xsl:attribute>
  <xsl:attribute name="visibility">
    <xsl:value-of select="@visibility" />
  </xsl:attribute>
  <xsl:apply-templates select="ownedParameter" />
</method>
</xsl:template>
<!-- Class operations template - END -->

<!-- Operation parameters template - START -->
<xsl:template match="ownedParameter[@xmi:type='uml:Parameter']">
  <parameter>
    <xsl:attribute name="name">
      <xsl:value-of select="@name" />
    </xsl:attribute>
    <xsl:attribute name="type">
      <xsl:value-of select="key('element',type/@xmi:idref)/@name" />
    </xsl:attribute>
  </parameter>
</xsl:template>
<!-- Operation parameters template - END -->

<xsl:template match="*">
  <xsl:apply-templates />
</xsl:template>

</xsl:stylesheet> 
