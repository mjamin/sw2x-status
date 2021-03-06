<status>
    <div class="status-bar-header">NYA drop out rate (withdrawn + bcash exodus)</div>
    <div class="status-bar">
        <div class="status-bar-inner" style={ { "width": getDropOutRate() } }>{ getDropOutRate() }</div>
    </div> 
    <table class="table">
        <colgroup>
            <col style="width:50%" />
            <col />
            <col />
            <col style="width:4rem" />
            <col style="width:2.5rem" />
        </colgroup>
        <thead class="thead-inverse">
            <tr>
                <th>Entity</th>
                <th>Status</th>
                <th>DCG portfolio?</th>
                <th colspan="2"></th>
            </tr>
        </thead>
        <tbody>
            <tr class="status-withdrawn" each={ entitiesByStatus[1] }>
                <th>{ entity }</th>
                <td><a if={withdrawnUrl} href="{withdrawnUrl}">{ parent.status[status] } &nbsp;<i class="fa fa-external-link"></i></a><span if={!withdrawnUrl}>{ parent.status[status] }</span></td>
                <td>{ dcg == true ? "Yes" : "" }</td>
                <td><a if={twitter} href="https://twitter.com/{twitter}"><i class="fa fa-twitter"></i></a></td>
                <td><a if={email} href="mailto:{email}"><i class="fa fa-envelope-o"></i></a></td>
            </tr>
        </tbody>
        <tbody>
            <tr class={ status-supports: !dcg, status-supports-dcg: dcg } each={ entitiesByStatus[2] }>
                <th>{ entity }</th>
                <td><a if={withdrawnUrl} href="{withdrawnUrl}">{ parent.status[status] } &nbsp;<i class="fa fa-external-link"></i></a><span if={!withdrawnUrl}>{ parent.status[status] }</span></td>
                <td>{ dcg == true ? "Yes" : "" }</td>
                <td><a if={twitter} href="https://twitter.com/{twitter}"><i class="fa fa-twitter"></i></a></td>
                <td><a if={email} href="mailto:{email}"><i class="fa fa-envelope-o"></i></a></td>
            </tr>
        </tbody>
        <tbody>
            <tr class="status-movedon" each={ entitiesByStatus[3] }>
                <th>{ entity }</th>
                <td><a if={withdrawnUrl} href="{withdrawnUrl}">{ parent.status[status] } &nbsp;<i class="fa fa-external-link"></i></a><span if={!withdrawnUrl}>{ parent.status[status] }</span></td>
                <td>{ dcg == true ? "Yes" : "" }</td>
                <td><a if={twitter} href="https://twitter.com/{twitter}"><i class="fa fa-twitter"></i></a></td>
                <td><a if={email} href="mailto:{email}"><i class="fa fa-envelope-o"></i></a></td>
            </tr>
        </tbody>
    </table>
    <script>
        var self = this;
        self.foo = true;
        self.entitiesByStatus = {};
        self.status = {
            1: "withdrawn",
            2: "supports",
            3: "moved on to BCash"
        };

        self.getDropOutRate = function() {
            return Math.round((1 - (self.entitiesByStatus[2].length / self.entitiesByStatus.total)) * 100) + '%';
        }

        xhr('get', 'entities.json', function(data) {
            var allEntities = JSON.parse(data);
            self.entitiesByStatus.total = allEntities.length;

            for(var i=0;i<allEntities.length;i++) {
                var e = allEntities[i];

                if(!self.entitiesByStatus.hasOwnProperty(e.status))
                    self.entitiesByStatus[e.status] = [];

                self.entitiesByStatus[e.status].push(e);
            }

            self.update();
        });
    </script>
</status>