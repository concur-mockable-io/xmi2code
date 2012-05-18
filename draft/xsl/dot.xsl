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
<xsl:output method="text" encoding="utf-8" />
<xsl:template match="/">
digraph <xsl:value-of select="@name" />{

<!-- Class drawing - START -->
node[shape="record"]
<xsl:for-each select="//packagedElement[@xmi:type='uml:Class']">
	<xsl:value-of select="@xmi:id" />
	<xsl:text>[label="{</xsl:text>
	<xsl:value-of select="@name" />
	<xsl:text>|</xsl:text>
	<xsl:apply-templates select="./ownedAttribute" />
	<xsl:text>|</xsl:text>
	<xsl:apply-templates select="./ownedOperation" />
	<xsl:text>}"]
</xsl:text>
</xsl:for-each>
<!-- Class drawing - END -->

<!-- Generalization drawing - START -->
edge [arrowhead = "empty"]
<xsl:for-each select="//packagedElement[@xmi:type='uml:Class']">
	<xsl:for-each select="./generalization">
		<xsl:value-of select="../@xmi:id" />
		<xsl:text>-></xsl:text>
		<xsl:value-of select="@general" />
		<xsl:text>[label="extends"];
</xsl:text>
	</xsl:for-each>
</xsl:for-each>
<!-- Generalization drawing - END -->

}
</xsl:template>

<!-- Drawing attributes - START -->
<xsl:template match="ownedAttribute">
	<xsl:value-of select="@name" /><xsl:text>\l</xsl:text>
</xsl:template>
<!-- Drawing attributes - END -->

<!-- Drawing operation - START -->
<xsl:template match="ownedOperation">
	<xsl:value-of select="@name" /><xsl:text>()\l</xsl:text>
</xsl:template>
<!-- Drawing operation - END -->

</xsl:stylesheet>
