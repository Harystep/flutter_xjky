webpackJsonp([36],{Y5am:function(t,e,i){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var o,n=i("a3Yh"),s=i.n(n),a=(i("mOxo"),i("MHxF")),r=i.n(a),c=(i("loei"),i("lBnC")),l=i.n(c),u=i("P7/f"),d={components:(o={},s()(o,l.a.name,l.a),s()(o,r.a.name,r.a),s()(o,"navBar",u.a),o),props:{},data:function(){return{phone:"",code:"",alreadyClick:!1,vCodeBtnText:"获取验证码"}},created:function(){console.log(this.$storage.get("historyUrl"))},mounted:function(){},methods:{clickLeft:function(){this.$router.back()},clickRight:function(){l()("按钮")},getCode:function(){var t=this;if("获取验证码"==this.vCodeBtnText){if(this.alreadyClick)return void l()("不要重复点击");if(""==this.phone)return this.$refs.myInput.focus(),void l()("输入正确的手机号");if(!/\d{11}/.test(this.phone))return l()("输入正确的手机号"),void this.$refs.myInput.focus();this.alreadyClick=!0,setTimeout(function(){t.alreadyClick=!1},500);var e=60,i=setInterval(function(){t.vCodeBtnText=e+"s 后重试",--e<0&&(clearInterval(i),t.getVCodeLock=!1,t.vCodeBtnText="获取验证码")},1e3);t.$api.getPhoneCode({mobile:t.phone}).then(function(t){console.log(t),"OK"==t.errMsg&&l()("短信发送成功,请注意查收")})}},submitButton:function(){var t=this,e=this;if(!this.alreadyClick)return""==this.phone?(this.$refs.myInput.focus(),void l()("输入正确的手机号")):/\d{11}/.test(this.phone)?void(""!=this.code?(this.alreadyClick=!0,setTimeout(function(){e.alreadyClick=!1},2e3),this.$api.wxBindMobile({code:this.code,mobile:this.phone}).then(function(e){console.log(e),"OK"==e.errMsg?(t.$router.replace("/mine"),l.a.success("绑定成功")):l.a.success(e.errMsg)})):l()("输入正确的验证码")):(this.$refs.myInput.focus(),void l()("输入正确的手机号"));l()("不要重复点击")},toPage:function(t){this.$router.push(t.url)}}},h={render:function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"bindingPhone"},[i("navBar",{attrs:{title:"绑定手机号码",hasBack:!0,leftText:"",rightText:"",clickLeft:t.clickLeft,clickRight:t.clickRight,hasBorder:!1}}),t._v(" "),i("div",{staticClass:"inputBox"},[i("div",{staticClass:"inputList phoneList"},[i("div",{staticClass:"label"},[t._v("+86")]),t._v(" "),i("input",{directives:[{name:"model",rawName:"v-model",value:t.phone,expression:"phone"}],ref:"myInput",attrs:{type:"text",placeholder:"输入手机号"},domProps:{value:t.phone},on:{input:function(e){e.target.composing||(t.phone=e.target.value)}}})]),t._v(" "),i("div",{staticClass:"codeList inputList"},[i("input",{directives:[{name:"model",rawName:"v-model",value:t.code,expression:"code"}],attrs:{type:"text",placeholder:"输入验证码"},domProps:{value:t.code},on:{input:function(e){e.target.composing||(t.code=e.target.value)}}}),t._v(" "),i("div",{directives:[{name:"tap",rawName:"v-tap",value:{methods:t.getCode},expression:"{methods:getCode}"}],staticClass:"button"},[t._v(t._s(t.vCodeBtnText))])])]),t._v(" "),i("div",{directives:[{name:"tap",rawName:"v-tap",value:{methods:t.submitButton},expression:"{methods:submitButton}"}],staticClass:"loginButton"},[t._v("绑定")])],1)},staticRenderFns:[]};var v=i("C7Lr")(d,h,!1,function(t){i("o7wZ")},"data-v-240fd994",null);e.default=v.exports},o7wZ:function(t,e){}});