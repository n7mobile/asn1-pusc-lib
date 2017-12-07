######################################################################
# Copyright (C) 2017 N7 Mobile sp. z o. o.
# Contact: http://n7mobile.pl/Space
#
# This file is part of ASN.1/ACN Plugin for QtCreator.
#
# Plugin was developed under a programme and funded by
# European Space Agency.
#
# This Plugin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This Plugin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#######################################################################

isEmpty(ASN1SCC): ASN1SCC = asn1.exe
isEmpty(ASN1SCC_PRODUCTS_DIR): ASN1SCC_PRODUCTS_DIR = $${OUT_PWD}/asn1sccGenerated/src
isEmpty(ASN1SCC_GENERATING_OPTIONS): ASN1SCC_GENERATING_OPTIONS = -c -ACN
isEmpty(ASN1SCC_ICD_DIR): ASN1SCC_ICD_DIR = $${OUT_PWD}/asn1sccGenerated/icd
isEmpty(ASN1SCC_ICD_FILE): ASN1SCC_ICD_FILE = ICD.html
isEmpty(ASN1SCC_ICD_OPTIONS): ASN1SCC_ICD_OPTIONS = -icdAcn

include(updateSourcesList.pri)
include(generateFromAsn1.pri)
