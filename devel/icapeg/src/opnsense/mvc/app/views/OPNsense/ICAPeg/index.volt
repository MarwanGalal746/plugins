{#

OPNsense® is Copyright © 2014 – 2015 by Deciso B.V.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

#}

<h1>ICAPeg General configuration </h1>
<ul class="nav nav-tabs" data-tabs="tabs" id="maintabs">
    <li class="active"><a data-toggle="tab" href="#general">{{ lang._('General') }}</a></li>
    <li><a data-toggle="tab" href="#echo">{{ lang._('Echo') }}</a></li>
</ul>
<div class="tab-content content-box tab-content">
    <div id="general" class="tab-pane fade in active">
        <div class="content-box" style="padding-bottom: 1.5em;">
            <h1>ICAPeg General configuration </h1>
            {{ partial("layout_partials/base_form",['fields':generalForm,'id':'frm_general_settings'])}}
            <div class="col-md-12">
                <hr />
                <button class="btn btn-primary"  id="saveAct" type="button"><b>{{ lang._('Save') }}</b> <i id="saveAct_progress"></i></button>
            </div>
        </div>
    </div>
    <div id="echo" class="tab-pane fade in active">
        <div class="content-box" style="padding-bottom: 1.5em;">
            <h1>Echo Service configuration </h1>
            {{ partial("layout_partials/base_form",['fields':echoForm,'id':'frm_echo_settings'])}}
            <div class="col-md-12">
                <hr />
                <button class="btn btn-primary"  id="saveAct" type="button"><b>{{ lang._('Save') }}</b> <i id="saveAct_progress"></i></button>
            </div>
        </div>
    </div>
</div>

<script>
    $( document ).ready(function() {
        var data_get_map = {'frm_GeneralSettings':"/api/icapeg/settings/get"};
        mapDataToFormUI(data_get_map).done(function(data){
            // place actions to run after load, for example update form styles.
            console.log(data)
            formatTokenizersUI();
            $('.selectpicker').selectpicker('refresh');
        });
        

        // link save button to API set action
        $("#saveAct").click(function(){
            saveFormToEndpoint(url="/api/icapeg/settings/set",formid='frm_GeneralSettings',callback_ok=function(){
                // action to run after successful save, for example reconfigure service.
                ajaxCall(url="/api/icapeg/service/reload", sendData={},callback=function(data,status) {
                    // action to run after reload
                    $("#responseMsg").html(data['status']);
                });
            });
        });

    });
</script>

<div class="alert alert-info hidden" role="alert" id="responseMsg">

</div>

<div  class="col-md-12">
    {{ partial("layout_partials/base_form",['fields':generalForm,'id':'frm_GeneralSettings'])}}
</div>

<div class="col-md-12">
    
    <button class="btn btn-primary"  id="saveAct" type="button"><b>{{ lang._('Save') }}</b></button>
</div>
