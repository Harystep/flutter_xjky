webpackJsonp([28],{DMQ3:function(t,e,a){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var n=a("a3Yh"),i=a.n(n),o=a("P7/f"),s=a("cMGX"),c=i()({components:{navBar:o.a,pagination:s.a},data:function(){return{over:!0,name:"",unUsedCount:"",pagination:{content:[],data:{page:1,pageSize:20,machineId:"",wholeCode:""}},requestUrl:"/ball/recordList"}},methods:{},created:function(){},mounted:function(){this.$refs.pagination.onRefresh()}},"methods",{clickLeft:function(){this.$router.back()},clickRight:function(){Toast("按钮")},renderFun:function(t){console.log(t),this.name=t.name,this.unUsedCount=t.unUsedCount;var e=[];this.pagination.data.page>1&&(e=this.pagination.content);for(var a=0;t.page.data&&a<t.page.data.length;a++)e.push(t.page.data[a]);this.pagination.content=e,console.log(this.pagination.content)},toDetail:function(t){this.$router.push(t.url)}}),r={render:function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"randomBall"},[n("navBar",{attrs:{title:"历史记录",hasBack:!0,leftText:"",rightText:"",clickLeft:t.clickLeft,clickRight:t.clickRight,hasBorder:!1}}),t._v(" "),n("pagination",{ref:"pagination",attrs:{render:t.renderFun,pagination:t.pagination,needToken:!1,uri:t.requestUrl}},[n("div",{staticClass:"scrollBox"},[n("div",{staticClass:"listBox"},[t._l(t.pagination.content,function(e,i){return n("div",{directives:[{name:"tap",rawName:"v-tap",value:{methods:t.toDetail,url:"/randomBallDetail?machineId="+e.machineId+"&wholeCode="+e.wholeCode},expression:"{methods:toDetail,url:'/randomBallDetail?machineId='+item.machineId+'&wholeCode='+item.wholeCode}"}],key:i,staticClass:"list"},[n("div",{staticClass:"label"},[t._v(t._s(e.machineRoomName))]),t._v(" "),n("div",{staticClass:"right"},[n("div",{staticClass:"time"},[t._v(t._s(e.createdTime.split(" ")[0]))]),t._v(" "),n("img",{attrs:{src:a("VtAm"),alt:""}})])])}),t._v(" "),t.pagination.content.length<=0?n("div",{staticClass:"noList"},[t._v("暂无记录~")]):t._e()],2)])])],1)},staticRenderFns:[]};var l=a("C7Lr")(c,r,!1,function(t){a("UmJH")},"data-v-a671c2fc",null);e.default=l.exports},UmJH:function(t,e){}});