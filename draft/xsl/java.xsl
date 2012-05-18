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
	<!-- Catching attribute visibility - START -->
	<xsl:variable name="visibility">
		<xsl:choose>
			<xsl:when test="@visibility='package'">
				<xsl:text>protected </xsl:text>
			</xsl:when>
			<xsl:when test="@visibility='private'">
				<xsl:text>private </xsl:text>
			</xsl:when>
			<xsl:when test="@visibility='public'">
				<xsl:text>public </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<!-- Catching attribute visibility - END -->

	<xsl:value-of select="$visibility" />
	<xsl:if test="@isAbstract='true'"><xsl:text>abstract </xsl:text></xsl:if>
	<xsl:text>class </xsl:text>
	<xsl:value-of select="@name" />
	<xsl:text> {&#xA;</xsl:text>
	<xsl:apply-templates select="./ownedAttribute" />
	<xsl:apply-templates select="./ownedOperation" />
	<xsl:text>}&#xA;</xsl:text>

</xsl:template>
<!-- Class template - END -->

<!-- Class attributes template - START --> 
<xsl:template match="ownedAttribute[@xmi:type='uml:Property']">

	<!-- Catching attribute visibility - START -->
	<xsl:variable name="visibility">
		<xsl:choose>
			<xsl:when test="@visibility='package'">
				<xsl:text>protected </xsl:text>
			</xsl:when>
			<xsl:when test="@visibility='private'">
				<xsl:text>private </xsl:text>
			</xsl:when>
			<xsl:when test="@visibility='public'">
				<xsl:text>public </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<!-- Catching attribute visibility - END -->

	<!-- Catching attribute type - START -->
	<xsl:variable name="type">
		<xsl:variable name="class_id" select="type/@xmi:idref" />
		<xsl:value-of select="concat(//packagedElement[@xmi:id=$class_id]/@name,' ')" />
	</xsl:variable>
	<!-- Catching attribute type - END -->

	<!-- Catching attribute name - START -->
	<xsl:variable name="name" select="@name" />
	<!-- Catching attribute name - END -->

	<xsl:value-of select="$visibility"/><xsl:value-of select="$type"/><xsl:value-of select="$name" /><xsl:text>;&#xA;</xsl:text>

</xsl:template>
<!-- Class attributes template - END --> 

<!-- Class operations template - START -->
<xsl:template match="ownedOperation[@xmi:type='uml:Operation']">

	<!-- Catching function visibility - START -->
	<xsl:variable name="visibility">
		<xsl:choose>
			<xsl:when test="@visibility='package'">
				<xsl:text>protected </xsl:text>
			</xsl:when>
			<xsl:when test="@visibility='private'">
				<xsl:text>private </xsl:text>
			</xsl:when>
			<xsl:when test="@visibility='public'">
				<xsl:text>public </xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<!-- Catching function visibility - END -->

	<!-- Catching function return type - START -->
	<xsl:variable name="type">
		<xsl:choose>
			<xsl:when test="ownedParameter[@direction='return']">
				<xsl:variable name="class_id" select="ownedParameter[@direction='return']/type/@xmi:idref" />
				<xsl:value-of select="concat(//packagedElement[@xmi:id=$class_id]/@name,' ')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>void </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- Catching function return type - END -->

	<!-- Catching function name - START -->
	<xsl:variable name="name" select="@name" />
	<!-- Catching function name - END -->


	<xsl:value-of select="$visibility"/><xsl:value-of select="$type"/><xsl:value-of select="$name" /><xsl:text>() {}&#xA;</xsl:text>

</xsl:template>
<!-- Class operations template - END -->

</xsl:stylesheet>
