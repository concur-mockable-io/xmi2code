<?xml version="1.0"?>
<!-- 
  Copyright (c) 2010 Charles-Edouard COSTE
  This program is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  This program is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
  PARTICULAR PURPOSE. See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along with
  this program.  If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1">
<xsl:output method="text" encoding="utf-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
<xsl:apply-templates />
</xsl:template>

<!-- Class template - START -->
<xsl:template match="packagedElement[@xmi:type='uml:Class']">
<xsl:if test="@isAbstract='true'">abstract </xsl:if>class <xsl:value-of select="@name" /> {
<xsl:apply-templates select="./ownedAttribute" />
<xsl:apply-templates select="./ownedOperation" />
}
</xsl:template>
<!-- Class template - END -->

<!-- Class attributes template - START --> 
<xsl:template match="ownedAttribute[@xmi:type='uml:Property']">
<xsl:choose>
	<xsl:when test="@visibility='package'">protected </xsl:when>
	<xsl:when test="@visibility='private'">private </xsl:when>
	<xsl:when test="@visibility='public'">public </xsl:when>
</xsl:choose>$<xsl:value-of select="@name" />;
</xsl:template>
<!-- Class attributes template - END --> 

<!-- Class operations template - START -->
<xsl:template match="ownedOperation[@xmi:type='uml:Operation']">
<xsl:choose>
	<xsl:when test="@visibility='package'">protected </xsl:when>
	<xsl:when test="@visibility='private'">private </xsl:when>
	<xsl:when test="@visibility='public'">public </xsl:when>
</xsl:choose>function <xsl:value-of select="@name" />() {

}
</xsl:template>
<!-- Class operations template - END -->

</xsl:stylesheet>
