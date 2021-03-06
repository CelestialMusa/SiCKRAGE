# Author: echel0n <echel0n@sickrage.ca>
# URL: https://sickrage.ca
#
# This file is part of SickRage.
#
# SickRage is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# SickRage is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with SickRage.  If not, see <http://www.gnu.org/licenses/>.

from __future__ import unicode_literals

import sickrage


def getShowImage(url, imgNum=None):
    if url is None:
        return None

    # if they provided a fanart number try to use it instead
    tempURL = url
    if imgNum:
        tempURL = url.split('-')[0] + "-" + str(imgNum) + ".jpg"

    sickrage.srCore.srLogger.debug("Fetching image from " + tempURL)

    try:
        return sickrage.srCore.srWebSession.get(tempURL).content
    except Exception:
        sickrage.srCore.srLogger.warning("There was an error trying to retrieve the image, aborting")
