<%inherit file="../layouts/main.mako"/>
<%!
    import sickrage
    import sickrage.subtitles
    from sickrage.core.helpers import anon_url
%>
<%block name="content">
    <div id="config">
        <form id="configForm" action="saveSubtitles" method="post">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#core-tab-pane1">Subtitles Search</a></li>
                <li><a data-toggle="tab" href="#core-tab-pane2">Subtitles Plugin</a></li>
                <li><a data-toggle="tab" href="#core-tab-pane3">Plugin Settings</a></li>
            </ul>

            <div class="tab-content">
                <div id="core-tab-pane1" class="tab-pane fade in active">

                    <div class="tab-pane-desc">
                        <h3>Subtitles Search</h3>
                        <p>Settings that dictate how SickRage handles subtitles search results.</p>
                    </div>

                    <fieldset class="tab-pane-list">
                        <div class="field-pair">
                            <label for="use_subtitles" class="clearfix">
                                <span class="component-title">Search Subtitles</span>
                                <span class="component-desc">
                                        <input type="checkbox"
                                               class="enabler" ${('', ' checked="checked"')[bool(sickrage.srCore.srConfig.USE_SUBTITLES)]}
                                               id="use_subtitles" name="use_subtitles">
                                    </span>
                            </label>
                        </div>
                        <div class="field-pair">
                            <label>
                                <span class="component-title">Subtitle Languages</span>
                                <span class="component-desc">
                                    <input type="text" class="form-control input-sm"
                                           id="subtitles_languages"
                                           name="subtitles_languages"
                                           value="${','.join(code for code in sickrage.subtitles.wanted_languages())}"
                                    />
                                </span>
                            </label>
                        </div>
                        <div class="field-pair">
                            <label>
                                <span class="component-title">Subtitle Directory</span>
                                <input type="text" value="${sickrage.srCore.srConfig.SUBTITLES_DIR}"
                                       id="subtitles_dir"
                                       name="subtitles_dir" class="form-control input-sm input350"
                                       autocapitalize="off"/>
                            </label>
                            <label>
                                <span class="component-title">&nbsp;</span>
                                <span class="component-desc">The directory where SickRage should store your <i>Subtitles</i> files.</span>
                            </label>
                            <label>
                                <span class="component-title">&nbsp;</span>
                                <span class="component-desc"><b>NOTE:</b> Leave empty if you want store subtitle in episode path.</span>
                            </label>
                        </div>
                        <div class="field-pair">
                            <label>
                                <span class="component-title">Subtitle Find Frequency</span>
                                <input type="number" name="subtitles_finder_frequency"
                                       value="${sickrage.srCore.srConfig.SUBTITLE_SEARCHER_FREQ}" hours="1"
                                       class="form-control input-sm input75"/>
                                <span class="component-desc">time in hours between scans (default: 1)</span>
                            </label>
                        </div>
                        <div class="field-pair">
                            <label class="clearfix" for="subtitles_history">
                                <span class="component-title">Subtitles History</span>
                                <span class="component-desc">
                                                <input type="checkbox" name="subtitles_history"
                                                       id="subtitles_history" ${('', 'checked="checked"')[bool(sickrage.srCore.srConfig.SUBTITLES_HISTORY)]}/>
                                                <p>Log downloaded Subtitle on History page?</p>
                                            </span>
                            </label>
                        </div>
                        <div class="field-pair">
                            <label class="clearfix" for="subtitles_multi">
                                <span class="component-title">Subtitles Multi-Language</span>
                                <span class="component-desc">
                                                <input type="checkbox" name="subtitles_multi"
                                                       id="subtitles_multi" ${('', 'checked="checked"')[bool(sickrage.srCore.srConfig.SUBTITLES_MULTI)]}/>
                                                <p>Append language codes to subtitle filenames?</p>
                                            </span>
                            </label>
                        </div>
                        <div class="field-pair">
                            <label class="clearfix" for="embedded_subtitles_all">
                                <span class="component-title">Embedded Subtitles</span>
                                <span class="component-desc">
                                                <input type="checkbox" name="embedded_subtitles_all"
                                                       id="embedded_subtitles_all" ${('', 'checked="checked"')[bool(sickrage.srCore.srConfig.EMBEDDED_SUBTITLES_ALL)]}/>
                                                <p>Ignore subtitles embedded inside video file?</p>
                                                <p><b>Warning: </b>this will ignore <u>all</u> embedded subtitles for every video file!</p>
                                            </span>
                            </label>
                        </div>
                        <div class="field-pair">
                            <label class="clearfix" for="subtitles_hearing_impaired">
                                <span class="component-title">Hearing Impaired Subtitles</span>
                                <span class="component-desc">
                                                <input type="checkbox" name="subtitles_hearing_impaired"
                                                       id="subtitles_hearing_impaired" ${('', 'checked="checked"')[bool(sickrage.srCore.srConfig.SUBTITLES_HEARING_IMPAIRED)]}/>
                                                <p>Download hearing impaired style subtitles?</p>
                                            </span>
                            </label>
                        </div>
                        <div class="field-pair">
                            <label class="nocheck">
                                <span class="component-title">Extra Scripts</span>
                                <input type="text" name="subtitles_extra_scripts"
                                       value="<% '|'.join(sickrage.srCore.srConfig.SUBTITLES_EXTRA_SCRIPTS) %>"
                                       class="form-control input-sm input350" autocapitalize="off"/>
                            </label>
                            <label class="nocheck">
                                <span class="component-title">&nbsp;</span>
                                <span class="component-desc"><b>NOTE:</b></span>
                            </label>
                            <label class="nocheck">
                                <span class="component-title">&nbsp;</span>
                                <span class="component-desc">
                                                <ul>
                                                        <li>See <a
                                                                href="https://git.sickrage.ca/SiCKRAGE/sickrage/wikis/Subtitle%20Scripts"><font
                                                                color='red'><b>Wiki</b></font></a> for a script arguments description.</li>
                                                        <li>Additional scripts separated by <b>|</b>.</li>
                                                        <li>Scripts are called after each episode has searched and downloaded subtitles.</li>
                                                        <li>For any scripted languages, include the interpreter executable before the script. See the following example:</li>
                                                        <ul>
                                                            <li>For Windows: <pre>C:\Python27\pythonw.exe C:\Script\test.py</pre></li>
                                                            <li>For Linux: <pre>python /Script/test.py</pre></li>
                                                        </ul>
                                                </ul>
                                            </span>
                            </label>
                        </div>

                        <br><input type="submit" class="btn config_submitter" value="Save Changes"/><br>
                    </fieldset>
                </div><!-- /tab-pane1 //-->

                <div id="core-tab-pane2" class="tab-pane fade">

                    <div class="tab-pane-desc">
                        <h3>Subtitle Plugins</h3>
                        <p>Check off and drag the plugins into the order you want them to be used.</p>
                        <p class="note">At least one plugin is required.</p>
                        <p class="note"><span style="font-size: 16px;">*</span> Web-scraping plugin</p>
                    </div>

                    <fieldset class="tab-pane-list" style="margin-left: 50px; margin-top:36px">
                        <ul id="service_order_list">
                            % for curService in sickrage.subtitles.sortedServiceList():
                                <li class="ui-state-default" id="${curService['name']}">
                                    <input type="checkbox" id="enable_${curService['name']}"
                                           class="service_enabler" ${('', 'checked="checked"')[curService['enabled'] == True]}/>
                                    <a href="${anon_url(curService['url'])}" class="imgLink" target="_new">
                                        <img src="${srWebRoot}/images/subtitles/${curService['image']}"
                                             alt="${curService['url']}" title="${curService['url']}" width="16"
                                             height="16" style="vertical-align:middle;"/>
                                    </a>
                                    <span style="vertical-align:middle;">${curService['name'].capitalize()}</span>
                                    <span class="ui-icon ui-icon-arrowthick-2-n-s pull-right"
                                          style="vertical-align:middle;"></span>
                                </li>
                            % endfor
                        </ul>
                        <input type="hidden" name="service_order" id="service_order"
                               value="<% ''.join(['%s:%d' % (x['name'], x['enabled']) for x in sickrage.subtitles.sortedServiceList()])%>"/>

                        <br><input type="submit" class="btn config_submitter" value="Save Changes"/><br>
                    </fieldset>
                </div><!-- /tab-pane2 //-->
                <div id="core-tab-pane3" class="tab-pane fade">
                    <div class="tab-pane-desc">
                        <h3>Subtitle Settings</h3>
                        <p>Set user and password for each provider</p>
                    </div><!-- /tab-pane-desc //-->

                    <fieldset class="tab-pane-list" style="margin-left: 50px; margin-top:36px">
                        <%
                            providerLoginDict = {
                                    'legendastv': {'user': sickrage.srCore.srConfig.LEGENDASTV_USER, 'pass': sickrage.srCore.srConfig.LEGENDASTV_PASS},
                                    'itasa': {'user': sickrage.srCore.srConfig.ITASA_USER, 'pass': sickrage.srCore.srConfig.ITASA_PASS},
                                    'addic7ed': {'user': sickrage.srCore.srConfig.ADDIC7ED_USER, 'pass': sickrage.srCore.srConfig.ADDIC7ED_PASS},
                                    'opensubtitles': {'user': sickrage.srCore.srConfig.OPENSUBTITLES_USER, 'pass': sickrage.srCore.srConfig.OPENSUBTITLES_PASS}}
                        %>
                        % for curService in sickrage.subtitles.sortedServiceList():
                            % if curService['name'] in providerLoginDict.keys():
                            ##<div class="field-pair${(' hidden', '')[curService['enabled']}"> ## Need js to show/hide on save

                                <div class="field-pair">
                                    <label class="nocheck" for="${curService['name']}_user">
                                        <span class="component-title">${curService['name'].capitalize()}
                                            User Name</span>
                                        <span class="component-desc">
                                                <input type="text" name="${curService['name']}_user"
                                                       id="${curService['name']}_user"
                                                       value="${providerLoginDict[curService['name']]['user']}"
                                                       class="form-control input-sm input300" autocapitalize="off"/>
                                            </span>
                                    </label>
                                    <label class="nocheck" for="${curService['name']}_pass">
                                        <span class="component-title">${curService['name'].capitalize()} Password</span>
                                        <span class="component-desc">
                                                <input type="password" name="${curService['name']}_pass"
                                                       id="${curService['name']}_pass"
                                                       value="${providerLoginDict[curService['name']]['pass']}"
                                                       class="form-control input-sm input300" autocapitalize="off"/>
                                            </span>
                                    </label>
                                </div>
                            % endif
                        % endfor
                        <br><input type="submit" class="btn config_submitter" value="Save Changes"/><br>
                    </fieldset>
                </div><!-- /tab-pane3 //-->
            </div><!-- /ui-components //-->
            <br><input type="submit" class="btn config_submitter" value="Save Changes"/><br>
        </form>
    </div>
</%block>