(function(){var supportsDirectProtoAccess=function(){var z=function(){}
z.prototype={p:{}}
var y=new z()
if(!(y.__proto__&&y.__proto__.p===z.prototype.p))return false
try{if(typeof navigator!="undefined"&&typeof navigator.userAgent=="string"&&navigator.userAgent.indexOf("Chrome/")>=0)return true
if(typeof version=="function"&&version.length==0){var x=version()
if(/^\d+\.\d+\.\d+\.\d+$/.test(x))return true}}catch(w){}return false}()
function map(a){a=Object.create(null)
a.x=0
delete a.x
return a}var A=map()
var B=map()
var C=map()
var D=map()
var E=map()
var F=map()
var G=map()
var H=map()
var J=map()
var K=map()
var L=map()
var M=map()
var N=map()
var O=map()
var P=map()
var Q=map()
var R=map()
var S=map()
var T=map()
var U=map()
var V=map()
var W=map()
var X=map()
var Y=map()
var Z=map()
function I(){}init()
function setupProgram(a,b,c){"use strict"
function generateAccessor(b0,b1,b2){var g=b0.split("-")
var f=g[0]
var e=f.length
var d=f.charCodeAt(e-1)
var a0
if(g.length>1)a0=true
else a0=false
d=d>=60&&d<=64?d-59:d>=123&&d<=126?d-117:d>=37&&d<=43?d-27:0
if(d){var a1=d&3
var a2=d>>2
var a3=f=f.substring(0,e-1)
var a4=f.indexOf(":")
if(a4>0){a3=f.substring(0,a4)
f=f.substring(a4+1)}if(a1){var a5=a1&2?"r":""
var a6=a1&1?"this":"r"
var a7="return "+a6+"."+f
var a8=b2+".prototype.g"+a3+"="
var a9="function("+a5+"){"+a7+"}"
if(a0)b1.push(a8+"$reflectable("+a9+");\n")
else b1.push(a8+a9+";\n")}if(a2){var a5=a2&2?"r,v":"v"
var a6=a2&1?"this":"r"
var a7=a6+"."+f+"=v"
var a8=b2+".prototype.s"+a3+"="
var a9="function("+a5+"){"+a7+"}"
if(a0)b1.push(a8+"$reflectable("+a9+");\n")
else b1.push(a8+a9+";\n")}}return f}function defineClass(a4,a5){var g=[]
var f="function "+a4+"("
var e="",d=""
for(var a0=0;a0<a5.length;a0++){var a1=a5[a0]
if(a1.charCodeAt(0)==48){a1=a1.substring(1)
var a2=generateAccessor(a1,g,a4)
d+="this."+a2+" = null;\n"}else{var a2=generateAccessor(a1,g,a4)
var a3="p_"+a2
f+=e
e=", "
f+=a3
d+="this."+a2+" = "+a3+";\n"}}if(supportsDirectProtoAccess)d+="this."+"$deferredAction"+"();"
f+=") {\n"+d+"}\n"
f+=a4+".builtin$cls=\""+a4+"\";\n"
f+="$desc=$collectedClasses."+a4+"[1];\n"
f+=a4+".prototype = $desc;\n"
if(typeof defineClass.name!="string")f+=a4+".name=\""+a4+"\";\n"
f+=g.join("")
return f}var z=supportsDirectProtoAccess?function(d,e){var g=d.prototype
g.__proto__=e.prototype
g.constructor=d
g["$is"+d.name]=d
return convertToFastObject(g)}:function(){function tmp(){}return function(a1,a2){tmp.prototype=a2.prototype
var g=new tmp()
convertToSlowObject(g)
var f=a1.prototype
var e=Object.keys(f)
for(var d=0;d<e.length;d++){var a0=e[d]
g[a0]=f[a0]}g["$is"+a1.name]=a1
g.constructor=a1
a1.prototype=g
return g}}()
function finishClasses(a5){var g=init.allClasses
a5.combinedConstructorFunction+="return [\n"+a5.constructorsList.join(",\n  ")+"\n]"
var f=new Function("$collectedClasses",a5.combinedConstructorFunction)(a5.collected)
a5.combinedConstructorFunction=null
for(var e=0;e<f.length;e++){var d=f[e]
var a0=d.name
var a1=a5.collected[a0]
var a2=a1[0]
a1=a1[1]
g[a0]=d
a2[a0]=d}f=null
var a3=init.finishedClasses
function finishClass(c2){if(a3[c2])return
a3[c2]=true
var a6=a5.pending[c2]
if(a6&&a6.indexOf("+")>0){var a7=a6.split("+")
a6=a7[0]
var a8=a7[1]
finishClass(a8)
var a9=g[a8]
var b0=a9.prototype
var b1=g[c2].prototype
var b2=Object.keys(b0)
for(var b3=0;b3<b2.length;b3++){var b4=b2[b3]
if(!u.call(b1,b4))b1[b4]=b0[b4]}}if(!a6||typeof a6!="string"){var b5=g[c2]
var b6=b5.prototype
b6.constructor=b5
b6.$isb=b5
b6.$deferredAction=function(){}
return}finishClass(a6)
var b7=g[a6]
if(!b7)b7=existingIsolateProperties[a6]
var b5=g[c2]
var b6=z(b5,b7)
if(b0)b6.$deferredAction=mixinDeferredActionHelper(b0,b6)
if(Object.prototype.hasOwnProperty.call(b6,"%")){var b8=b6["%"].split(";")
if(b8[0]){var b9=b8[0].split("|")
for(var b3=0;b3<b9.length;b3++){init.interceptorsByTag[b9[b3]]=b5
init.leafTags[b9[b3]]=true}}if(b8[1]){b9=b8[1].split("|")
if(b8[2]){var c0=b8[2].split("|")
for(var b3=0;b3<c0.length;b3++){var c1=g[c0[b3]]
c1.$nativeSuperclassTag=b9[0]}}for(b3=0;b3<b9.length;b3++){init.interceptorsByTag[b9[b3]]=b5
init.leafTags[b9[b3]]=false}}b6.$deferredAction()}if(b6.$isx)b6.$deferredAction()}var a4=Object.keys(a5.pending)
for(var e=0;e<a4.length;e++)finishClass(a4[e])}function finishAddStubsHelper(){var g=this
while(!g.hasOwnProperty("$deferredAction"))g=g.__proto__
delete g.$deferredAction
var f=Object.keys(g)
for(var e=0;e<f.length;e++){var d=f[e]
var a0=d.charCodeAt(0)
var a1
if(d!=="^"&&d!=="$reflectable"&&a0!==43&&a0!==42&&(a1=g[d])!=null&&a1.constructor===Array&&d!=="<>")addStubs(g,a1,d,false,[])}convertToFastObject(g)
g=g.__proto__
g.$deferredAction()}function mixinDeferredActionHelper(d,e){var g
if(e.hasOwnProperty("$deferredAction"))g=e.$deferredAction
return function foo(){if(!supportsDirectProtoAccess)return
var f=this
while(!f.hasOwnProperty("$deferredAction"))f=f.__proto__
if(g)f.$deferredAction=g
else{delete f.$deferredAction
convertToFastObject(f)}d.$deferredAction()
f.$deferredAction()}}function processClassData(b2,b3,b4){b3=convertToSlowObject(b3)
var g
var f=Object.keys(b3)
var e=false
var d=supportsDirectProtoAccess&&b2!="b"
for(var a0=0;a0<f.length;a0++){var a1=f[a0]
var a2=a1.charCodeAt(0)
if(a1==="m"){processStatics(init.statics[b2]=b3.m,b4)
delete b3.m}else if(a2===43){w[g]=a1.substring(1)
var a3=b3[a1]
if(a3>0)b3[g].$reflectable=a3}else if(a2===42){b3[g].$D=b3[a1]
var a4=b3.$methodsWithOptionalArguments
if(!a4)b3.$methodsWithOptionalArguments=a4={}
a4[a1]=g}else{var a5=b3[a1]
if(a1!=="^"&&a5!=null&&a5.constructor===Array&&a1!=="<>")if(d)e=true
else addStubs(b3,a5,a1,false,[])
else g=a1}}if(e)b3.$deferredAction=finishAddStubsHelper
var a6=b3["^"],a7,a8,a9=a6
var b0=a9.split(";")
a9=b0[1]?b0[1].split(","):[]
a8=b0[0]
a7=a8.split(":")
if(a7.length==2){a8=a7[0]
var b1=a7[1]
if(b1)b3.$S=function(b5){return function(){return init.types[b5]}}(b1)}if(a8)b4.pending[b2]=a8
b4.combinedConstructorFunction+=defineClass(b2,a9)
b4.constructorsList.push(b2)
b4.collected[b2]=[m,b3]
i.push(b2)}function processStatics(a4,a5){var g=Object.keys(a4)
for(var f=0;f<g.length;f++){var e=g[f]
if(e==="^")continue
var d=a4[e]
var a0=e.charCodeAt(0)
var a1
if(a0===43){v[a1]=e.substring(1)
var a2=a4[e]
if(a2>0)a4[a1].$reflectable=a2
if(d&&d.length)init.typeInformation[a1]=d}else if(a0===42){m[a1].$D=d
var a3=a4.$methodsWithOptionalArguments
if(!a3)a4.$methodsWithOptionalArguments=a3={}
a3[e]=a1}else if(typeof d==="function"){m[a1=e]=d
h.push(e)}else if(d.constructor===Array)addStubs(m,d,e,true,h)
else{a1=e
processClassData(e,d,a5)}}}function addStubs(c0,c1,c2,c3,c4){var g=0,f=g,e=c1[g],d
if(typeof e=="string")d=c1[++g]
else{d=e
e=c2}if(typeof d=="number"){f=d
d=c1[++g]}c0[c2]=c0[e]=d
var a0=[d]
d.$stubName=c2
c4.push(c2)
for(g++;g<c1.length;g++){d=c1[g]
if(typeof d!="function")break
if(!c3)d.$stubName=c1[++g]
a0.push(d)
if(d.$stubName){c0[d.$stubName]=d
c4.push(d.$stubName)}}for(var a1=0;a1<a0.length;g++,a1++)a0[a1].$callName=c1[g]
var a2=c1[g]
c1=c1.slice(++g)
var a3=c1[0]
var a4=(a3&1)===1
a3=a3>>1
var a5=a3>>1
var a6=(a3&1)===1
var a7=a3===3
var a8=a3===1
var a9=c1[1]
var b0=a9>>1
var b1=(a9&1)===1
var b2=a5+b0
var b3=c1[2]
if(typeof b3=="number")c1[2]=b3+c
if(b>0){var b4=3
for(var a1=0;a1<b0;a1++){if(typeof c1[b4]=="number")c1[b4]=c1[b4]+b
b4++}for(var a1=0;a1<b2;a1++){c1[b4]=c1[b4]+b
b4++}}var b5=2*b0+a5+3
if(a2){d=tearOff(a0,f,c1,c3,c2,a4)
c0[c2].$getter=d
d.$getterStub=true
if(c3)c4.push(a2)
c0[a2]=d
a0.push(d)
d.$stubName=a2
d.$callName=null}var b6=c1.length>b5
if(b6){a0[0].$reflectable=1
a0[0].$reflectionInfo=c1
for(var a1=1;a1<a0.length;a1++){a0[a1].$reflectable=2
a0[a1].$reflectionInfo=c1}var b7=c3?init.mangledGlobalNames:init.mangledNames
var b8=c1[b5]
var b9=b8
if(a2)b7[a2]=b9
if(a7)b9+="="
else if(!a8)b9+=":"+(a5+b0)
b7[c2]=b9
a0[0].$reflectionName=b9
for(var a1=b5+1;a1<c1.length;a1++)c1[a1]=c1[a1]+b
a0[0].$metadataIndex=b5+1
if(b0)c0[b8+"*"]=a0[f]}}function tearOffGetter(d,e,f,g,a0){return a0?new Function("funcs","applyTrampolineIndex","reflectionInfo","name","H","c","return function tearOff_"+g+y+++"(receiver) {"+"if (c === null) c = "+"H.cE"+"("+"this, funcs, applyTrampolineIndex, reflectionInfo, false, true, name);"+"return new c(this, funcs[0], receiver, name);"+"}")(d,e,f,g,H,null):new Function("funcs","applyTrampolineIndex","reflectionInfo","name","H","c","return function tearOff_"+g+y+++"() {"+"if (c === null) c = "+"H.cE"+"("+"this, funcs, applyTrampolineIndex, reflectionInfo, false, false, name);"+"return new c(this, funcs[0], null, name);"+"}")(d,e,f,g,H,null)}function tearOff(d,e,f,a0,a1,a2){var g=null
return a0?function(){if(g===null)g=H.cE(this,d,e,f,true,false,a1).prototype
return g}:tearOffGetter(d,e,f,a1,a2)}var y=0
if(!init.libraries)init.libraries=[]
if(!init.mangledNames)init.mangledNames=map()
if(!init.mangledGlobalNames)init.mangledGlobalNames=map()
if(!init.statics)init.statics=map()
if(!init.typeInformation)init.typeInformation=map()
var x=init.libraries
var w=init.mangledNames
var v=init.mangledGlobalNames
var u=Object.prototype.hasOwnProperty
var t=a.length
var s=map()
s.collected=map()
s.pending=map()
s.constructorsList=[]
s.combinedConstructorFunction="function $reflectable(fn){fn.$reflectable=1;return fn};\n"+"var $desc;\n"
for(var r=0;r<t;r++){var q=a[r]
var p=q[0]
var o=q[1]
var n=q[2]
var m=q[3]
var l=q[4]
var k=!!q[5]
var j=l&&l["^"]
if(j instanceof Array)j=j[0]
var i=[]
var h=[]
processStatics(l,s)
x.push([p,o,i,h,n,j,k,m])}finishClasses(s)}I.cG=function(){}
var dart=[["","",,H,{"^":"",kJ:{"^":"b;a"}}],["","",,J,{"^":"",
cL:function(a,b,c,d){return{i:a,p:b,e:c,x:d}},
bN:function(a){var z,y,x,w,v
z=a[init.dispatchPropertyName]
if(z==null)if($.cJ==null){H.kl()
z=a[init.dispatchPropertyName]}if(z!=null){y=z.p
if(!1===y)return z.i
if(!0===y)return a
x=Object.getPrototypeOf(a)
if(y===x)return z.i
if(z.e===x)throw H.e(P.dU("Return interceptor for "+H.f(y(a,z))))}w=a.constructor
v=w==null?null:w[$.$get$c8()]
if(v!=null)return v
v=H.ks(a)
if(v!=null)return v
if(typeof a=="function")return C.P
y=Object.getPrototypeOf(a)
if(y==null)return C.B
if(y===Object.prototype)return C.B
if(typeof w=="function"){Object.defineProperty(w,$.$get$c8(),{value:C.t,enumerable:false,writable:true,configurable:true})
return C.t}return C.t},
x:{"^":"b;",
T:function(a,b){return a===b},
gE:function(a){return H.aR(a)},
i:["bV",function(a){return"Instance of '"+H.aS(a)+"'"}],
aT:["bU",function(a,b){H.d(b,"$isc5")
throw H.e(P.dq(a,b.gbB(),b.gbE(),b.gbC(),null))}],
"%":"DOMError|MediaError|Navigator|NavigatorConcurrentHardware|NavigatorUserMediaError|OverconstrainedError|PositionError|SQLError|Screen"},
h2:{"^":"x;",
i:function(a){return String(a)},
gE:function(a){return a?519018:218159},
$isz:1},
h4:{"^":"x;",
T:function(a,b){return null==b},
i:function(a){return"null"},
gE:function(a){return 0},
aT:function(a,b){return this.bU(a,H.d(b,"$isc5"))},
$isk:1},
c9:{"^":"x;",
gE:function(a){return 0},
i:["bX",function(a){return String(a)}]},
id:{"^":"c9;"},
bH:{"^":"c9;"},
b4:{"^":"c9;",
i:function(a){var z=a[$.$get$bq()]
if(z==null)return this.bX(a)
return"JavaScript function for "+H.f(J.B(z))},
$S:function(){return{func:1,opt:[,,,,,,,,,,,,,,,,]}},
$isaf:1},
b3:{"^":"x;$ti",
p:function(a,b){H.l(b,H.i(a,0))
if(!!a.fixed$length)H.S(P.Q("add"))
a.push(b)},
a1:function(a,b,c){var z
H.l(c,H.i(a,0))
if(!!a.fixed$length)H.S(P.Q("insert"))
z=a.length
if(b>z)throw H.e(P.b9(b,null,null))
a.splice(b,0,c)},
R:function(a,b){var z
if(!!a.fixed$length)H.S(P.Q("remove"))
for(z=0;z<a.length;++z)if(J.bg(a[z],b)){a.splice(z,1)
return!0}return!1},
M:function(a,b){var z
H.V(b,"$isp",[H.i(a,0)],"$asp")
if(!!a.fixed$length)H.S(P.Q("addAll"))
for(z=J.at(b);z.t();)a.push(z.gw())},
q:function(a,b){var z,y
H.c(b,{func:1,ret:-1,args:[H.i(a,0)]})
z=a.length
for(y=0;y<z;++y){b.$1(a[y])
if(a.length!==z)throw H.e(P.a4(a))}},
bA:function(a,b,c){var z=H.i(a,0)
return new H.bD(a,H.c(b,{func:1,ret:c,args:[z]}),[z,c])},
C:function(a,b){return this.l(a,b)},
gam:function(a){if(a.length>0)return a[0]
throw H.e(H.c7())},
bp:function(a,b){var z,y
H.c(b,{func:1,ret:P.z,args:[H.i(a,0)]})
z=a.length
for(y=0;y<z;++y){if(b.$1(a[y]))return!0
if(a.length!==z)throw H.e(P.a4(a))}return!1},
v:function(a,b){var z
for(z=0;z<a.length;++z)if(J.bg(a[z],b))return!0
return!1},
i:function(a){return P.c6(a,"[","]")},
gB:function(a){return new J.bm(a,a.length,0,[H.i(a,0)])},
gE:function(a){return H.aR(a)},
gk:function(a){return a.length},
sk:function(a,b){if(!!a.fixed$length)H.S(P.Q("set length"))
if(typeof b!=="number"||Math.floor(b)!==b)throw H.e(P.bl(b,"newLength",null))
if(b<0)throw H.e(P.az(b,0,null,"newLength",null))
a.length=b},
l:function(a,b){if(typeof b!=="number"||Math.floor(b)!==b)throw H.e(H.aq(a,b))
if(b>=a.length||b<0)throw H.e(H.aq(a,b))
return a[b]},
D:function(a,b,c){H.l(c,H.i(a,0))
if(!!a.immutable$list)H.S(P.Q("indexed set"))
if(b>=a.length||b<0)throw H.e(H.aq(a,b))
a[b]=c},
$isp:1,
$ist:1,
m:{
h1:function(a,b){return J.bv(H.y(a,[b]))},
bv:function(a){H.aZ(a)
a.fixed$length=Array
return a}}},
kI:{"^":"b3;$ti"},
bm:{"^":"b;a,b,c,0d,$ti",
sbc:function(a){this.d=H.l(a,H.i(this,0))},
gw:function(){return this.d},
t:function(){var z,y,x
z=this.a
y=z.length
if(this.b!==y)throw H.e(H.cO(z))
x=this.c
if(x>=y){this.sbc(null)
return!1}this.sbc(z[x]);++this.c
return!0},
$isah:1},
bw:{"^":"x;",
gda:function(a){return a===0?1/a<0:a<0},
dz:function(a){var z
if(a>=-2147483648&&a<=2147483647)return a|0
if(isFinite(a)){z=a<0?Math.ceil(a):Math.floor(a)
return z+0}throw H.e(P.Q(""+a+".toInt()"))},
u:function(a){var z,y
if(a>=0){if(a<=2147483647)return a|0}else if(a>=-2147483648){z=a|0
return a===z?z:z-1}y=Math.floor(a)
if(isFinite(y))return y
throw H.e(P.Q(""+a+".floor()"))},
bI:function(a,b){var z
if(b>20)throw H.e(P.az(b,0,20,"fractionDigits",null))
z=a.toFixed(b)
if(a===0&&this.gda(a))return"-"+z
return z},
i:function(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
gE:function(a){return a&0x1FFFFFFF},
c0:function(a,b){if((a|0)===a)if(b>=1||b<-1)return a/b|0
return this.bn(a,b)},
ab:function(a,b){return(a|0)===a?a/b|0:this.bn(a,b)},
bn:function(a,b){var z=a/b
if(z>=-2147483648&&z<=2147483647)return z|0
if(z>0){if(z!==1/0)return Math.floor(z)}else if(z>-1/0)return Math.ceil(z)
throw H.e(P.Q("Result of truncating division is "+H.f(z)+": "+H.f(a)+" ~/ "+b))},
bl:function(a,b){var z
if(a>0)z=this.cH(a,b)
else{z=b>31?31:b
z=a>>z>>>0}return z},
cH:function(a,b){return b>31?0:a>>>b},
Z:function(a,b){if(typeof b!=="number")throw H.e(H.aH(b))
return a<b},
$isaI:1,
$iscM:1},
dh:{"^":"bw;",$isw:1},
dg:{"^":"bw;"},
bx:{"^":"x;",
bu:function(a,b){if(b<0)throw H.e(H.aq(a,b))
if(b>=a.length)H.S(H.aq(a,b))
return a.charCodeAt(b)},
az:function(a,b){if(b>=a.length)throw H.e(H.aq(a,b))
return a.charCodeAt(b)},
A:function(a,b){H.m(b)
if(typeof b!=="string")throw H.e(P.bl(b,null,null))
return a+b},
bS:function(a,b,c){var z
if(c>a.length)throw H.e(P.az(c,0,a.length,null,null))
z=c+b.length
if(z>a.length)return!1
return b===a.substring(c,z)},
bR:function(a,b){return this.bS(a,b,0)},
b2:function(a,b,c){if(c==null)c=a.length
if(b<0)throw H.e(P.b9(b,null,null))
if(b>c)throw H.e(P.b9(b,null,null))
if(c>a.length)throw H.e(P.b9(c,null,null))
return a.substring(b,c)},
b1:function(a,b){return this.b2(a,b,null)},
dC:function(a){return a.toLowerCase()},
dD:function(a){var z,y,x,w,v
z=a.trim()
y=z.length
if(y===0)return z
if(this.az(z,0)===133){x=J.h5(z,1)
if(x===y)return""}else x=0
w=y-1
v=this.bu(z,w)===133?J.h6(z,w):y
if(x===0&&v===y)return z
return z.substring(x,v)},
cW:function(a,b,c){if(c>a.length)throw H.e(P.az(c,0,a.length,null,null))
return H.kA(a,b,c)},
i:function(a){return a},
gE:function(a){var z,y,x
for(z=a.length,y=0,x=0;x<z;++x){y=536870911&y+a.charCodeAt(x)
y=536870911&y+((524287&y)<<10)
y^=y>>6}y=536870911&y+((67108863&y)<<3)
y^=y>>11
return 536870911&y+((16383&y)<<15)},
gk:function(a){return a.length},
$isdt:1,
$ish:1,
m:{
di:function(a){if(a<256)switch(a){case 9:case 10:case 11:case 12:case 13:case 32:case 133:case 160:return!0
default:return!1}switch(a){case 5760:case 8192:case 8193:case 8194:case 8195:case 8196:case 8197:case 8198:case 8199:case 8200:case 8201:case 8202:case 8232:case 8233:case 8239:case 8287:case 12288:case 65279:return!0
default:return!1}},
h5:function(a,b){var z,y
for(z=a.length;b<z;){y=C.k.az(a,b)
if(y!==32&&y!==13&&!J.di(y))break;++b}return b},
h6:function(a,b){var z,y
for(;b>0;b=z){z=b-1
y=C.k.bu(a,z)
if(y!==32&&y!==13&&!J.di(y))break}return b}}}}],["","",,H,{"^":"",
c7:function(){return new P.cj("No element")},
h0:function(){return new P.cj("Too many elements")},
c0:{"^":"p;"},
aj:{"^":"c0;$ti",
gB:function(a){return new H.dp(this,this.gk(this),0,[H.aY(this,"aj",0)])},
d4:function(a,b,c){var z,y,x
H.c(b,{func:1,ret:P.z,args:[H.aY(this,"aj",0)]})
z=this.gk(this)
if(typeof z!=="number")return H.j(z)
y=0
for(;y<z;++y){x=this.C(0,y)
if(b.$1(x))return x
if(z!==this.gk(this))throw H.e(P.a4(this))}throw H.e(H.c7())},
d3:function(a,b){return this.d4(a,b,null)},
aZ:function(a,b){return this.bW(0,H.c(b,{func:1,ret:P.z,args:[H.aY(this,"aj",0)]}))}},
iD:{"^":"aj;a,b,c,$ti",
gck:function(){var z=J.a1(this.a)
return z},
gcJ:function(){var z,y
z=J.a1(this.a)
y=this.b
if(typeof z!=="number")return H.j(z)
if(y>z)return z
return y},
gk:function(a){var z,y
z=J.a1(this.a)
y=this.b
if(typeof z!=="number")return H.j(z)
if(y>=z)return 0
return z-y},
C:function(a,b){var z,y
z=this.gcJ()
if(typeof z!=="number")return z.A()
if(typeof b!=="number")return H.j(b)
y=z+b
if(b>=0){z=this.gck()
if(typeof z!=="number")return H.j(z)
z=y>=z}else z=!0
if(z)throw H.e(P.ax(b,this,"index",null,null))
return J.bi(this.a,y)},
m:{
iE:function(a,b,c,d){return new H.iD(a,b,c,[d])}}},
dp:{"^":"b;a,b,c,0d,$ti",
sa6:function(a){this.d=H.l(a,H.i(this,0))},
gw:function(){return this.d},
t:function(){var z,y,x,w
z=this.a
y=J.bd(z)
x=y.gk(z)
if(this.b!=x)throw H.e(P.a4(z))
w=this.c
if(typeof x!=="number")return H.j(x)
if(w>=x){this.sa6(null)
return!1}this.sa6(y.C(z,w));++this.c
return!0},
$isah:1},
i2:{"^":"p;a,b,$ti",
gB:function(a){return new H.i3(J.at(this.a),this.b,this.$ti)},
gk:function(a){return J.a1(this.a)},
C:function(a,b){return this.b.$1(J.bi(this.a,b))},
$asp:function(a,b){return[b]}},
i3:{"^":"ah;0a,b,c,$ti",
sa6:function(a){this.a=H.l(a,H.i(this,1))},
t:function(){var z=this.b
if(z.t()){this.sa6(this.c.$1(z.gw()))
return!0}this.sa6(null)
return!1},
gw:function(){return this.a},
$asah:function(a,b){return[b]}},
bD:{"^":"aj;a,b,$ti",
gk:function(a){return J.a1(this.a)},
C:function(a,b){return this.b.$1(J.bi(this.a,b))},
$asaj:function(a,b){return[b]},
$asp:function(a,b){return[b]}},
co:{"^":"p;a,b,$ti",
gB:function(a){return new H.iO(J.at(this.a),this.b,this.$ti)}},
iO:{"^":"ah;a,b,$ti",
t:function(){var z,y
for(z=this.a,y=this.b;z.t();)if(y.$1(z.gw()))return!0
return!1},
gw:function(){return this.a.gw()}},
bu:{"^":"b;$ti"},
cm:{"^":"b;a",
gE:function(a){var z=this._hashCode
if(z!=null)return z
z=536870911&664597*J.bj(this.a)
this._hashCode=z
return z},
i:function(a){return'Symbol("'+H.f(this.a)+'")'},
T:function(a,b){if(b==null)return!1
return b instanceof H.cm&&this.a==b.a},
$isaA:1}}],["","",,H,{"^":"",
es:function(a){var z=J.u(a)
return!!z.$iscX||!!z.$isU||!!z.$isdj||!!z.$isdf||!!z.$isn||!!z.$iscp||!!z.$isdV}}],["","",,H,{"^":"",
fa:function(){throw H.e(P.Q("Cannot modify unmodifiable Map"))},
aK:function(a){var z,y
z=H.m(init.mangledGlobalNames[a])
if(typeof z==="string")return z
y="minified:"+a
return y},
ke:[function(a){return init.types[H.M(a)]},null,null,4,0,null,8],
ko:function(a,b){var z
if(b!=null){z=b.x
if(z!=null)return z}return!!J.u(a).$isaa},
f:function(a){var z
if(typeof a==="string")return a
if(typeof a==="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
z=J.B(a)
if(typeof z!=="string")throw H.e(H.aH(a))
return z},
aR:function(a){var z=a.$identityHash
if(z==null){z=Math.random()*0x3fffffff|0
a.$identityHash=z}return z},
ir:function(a,b){var z,y
if(typeof a!=="string")H.S(H.aH(a))
z=/^\s*[+-]?((0x[a-f0-9]+)|(\d+)|([a-z0-9]+))\s*$/i.exec(a)
if(z==null)return
if(3>=z.length)return H.A(z,3)
y=H.m(z[3])
if(y!=null)return parseInt(a,10)
if(z[2]!=null)return parseInt(a,16)
return},
aS:function(a){return H.ig(a)+H.cB(H.ar(a),0,null)},
ig:function(a){var z,y,x,w,v,u,t,s,r
z=J.u(a)
y=z.constructor
if(typeof y=="function"){x=y.name
w=typeof x==="string"?x:null}else w=null
v=w==null
if(v||z===C.I||!!z.$isbH){u=C.x(a)
if(v)w=u
if(u==="Object"){t=a.constructor
if(typeof t=="function"){s=String(t).match(/^\s*function\s*([\w$]*)\s*\(/)
r=s==null?null:s[1]
if(typeof r==="string"&&/^\w+$/.test(r))w=r}}return w}w=w
return H.aK(w.length>1&&C.k.az(w,0)===36?C.k.b1(w,1):w)},
am:function(a){if(a.date===void 0)a.date=new Date(a.a)
return a.date},
iq:function(a){var z=H.am(a).getFullYear()+0
return z},
io:function(a){var z=H.am(a).getMonth()+1
return z},
ij:function(a){var z=H.am(a).getDate()+0
return z},
ik:function(a){var z=H.am(a).getHours()+0
return z},
im:function(a){var z=H.am(a).getMinutes()+0
return z},
ip:function(a){var z=H.am(a).getSeconds()+0
return z},
il:function(a){var z=H.am(a).getMilliseconds()+0
return z},
du:function(a,b,c){var z,y,x
z={}
H.V(c,"$isK",[P.h,null],"$asK")
z.a=0
y=[]
x=[]
z.a=b.length
C.b.M(y,b)
z.b=""
if(c!=null&&!c.gbz(c))c.q(0,new H.ii(z,x,y))
return J.eJ(a,new H.h3(C.W,""+"$"+z.a+z.b,0,y,x,0))},
ih:function(a,b){var z,y
z=b instanceof Array?b:P.ay(b,!0,null)
y=z.length
if(y===0){if(!!a.$0)return a.$0()}else if(y===1){if(!!a.$1)return a.$1(z[0])}else if(y===2){if(!!a.$2)return a.$2(z[0],z[1])}else if(y===3){if(!!a.$3)return a.$3(z[0],z[1],z[2])}else if(y===4){if(!!a.$4)return a.$4(z[0],z[1],z[2],z[3])}else if(y===5)if(!!a.$5)return a.$5(z[0],z[1],z[2],z[3],z[4])
return H.ie(a,z)},
ie:function(a,b){var z,y,x,w,v,u
z=b.length
y=a[""+"$"+z]
if(y==null){y=J.u(a)["call*"]
if(y==null)return H.du(a,b,null)
x=H.dw(y)
w=x.d
v=w+x.e
if(x.f||w>z||v<z)return H.du(a,b,null)
b=P.ay(b,!0,null)
for(u=z;u<v;++u)C.b.p(b,init.metadata[x.d2(0,u)])}return y.apply(a,b)},
j:function(a){throw H.e(H.aH(a))},
A:function(a,b){if(a==null)J.a1(a)
throw H.e(H.aq(a,b))},
aq:function(a,b){var z,y
if(typeof b!=="number"||Math.floor(b)!==b)return new P.a8(!0,b,"index",null)
z=H.M(J.a1(a))
if(!(b<0)){if(typeof z!=="number")return H.j(z)
y=b>=z}else y=!0
if(y)return P.ax(b,a,"index",null,z)
return P.b9(b,"index",null)},
aH:function(a){return new P.a8(!0,a,null,null)},
e:function(a){var z
if(a==null)a=new P.cg()
z=new Error()
z.dartException=a
if("defineProperty" in Object){Object.defineProperty(z,"message",{get:H.ey})
z.name=""}else z.toString=H.ey
return z},
ey:[function(){return J.B(this.dartException)},null,null,0,0,null],
S:function(a){throw H.e(a)},
cO:function(a){throw H.e(P.a4(a))},
N:function(a){var z,y,x,w,v,u,t,s,r,q,p,o,n,m,l
z=new H.kC(a)
if(a==null)return
if(a instanceof H.c2)return z.$1(a.a)
if(typeof a!=="object")return a
if("dartException" in a)return z.$1(a.dartException)
else if(!("message" in a))return a
y=a.message
if("number" in a&&typeof a.number=="number"){x=a.number
w=x&65535
if((C.f.bl(x,16)&8191)===10)switch(w){case 438:return z.$1(H.cc(H.f(y)+" (Error "+w+")",null))
case 445:case 5007:return z.$1(H.ds(H.f(y)+" (Error "+w+")",null))}}if(a instanceof TypeError){v=$.$get$dH()
u=$.$get$dI()
t=$.$get$dJ()
s=$.$get$dK()
r=$.$get$dO()
q=$.$get$dP()
p=$.$get$dM()
$.$get$dL()
o=$.$get$dR()
n=$.$get$dQ()
m=v.P(y)
if(m!=null)return z.$1(H.cc(H.m(y),m))
else{m=u.P(y)
if(m!=null){m.method="call"
return z.$1(H.cc(H.m(y),m))}else{m=t.P(y)
if(m==null){m=s.P(y)
if(m==null){m=r.P(y)
if(m==null){m=q.P(y)
if(m==null){m=p.P(y)
if(m==null){m=s.P(y)
if(m==null){m=o.P(y)
if(m==null){m=n.P(y)
l=m!=null}else l=!0}else l=!0}else l=!0}else l=!0}else l=!0}else l=!0}else l=!0
if(l)return z.$1(H.ds(H.m(y),m))}}return z.$1(new H.iL(typeof y==="string"?y:""))}if(a instanceof RangeError){if(typeof y==="string"&&y.indexOf("call stack")!==-1)return new P.dB()
y=function(b){try{return String(b)}catch(k){}return null}(a)
return z.$1(new P.a8(!1,null,null,typeof y==="string"?y.replace(/^RangeError:\s*/,""):y))}if(typeof InternalError=="function"&&a instanceof InternalError)if(typeof y==="string"&&y==="too much recursion")return new P.dB()
return a},
as:function(a){var z
if(a instanceof H.c2)return a.b
if(a==null)return new H.e9(a)
z=a.$cachedTrace
if(z!=null)return z
return a.$cachedTrace=new H.e9(a)},
kn:[function(a,b,c,d,e,f){H.d(a,"$isaf")
switch(H.M(b)){case 0:return a.$0()
case 1:return a.$1(c)
case 2:return a.$2(c,d)
case 3:return a.$3(c,d,e)
case 4:return a.$4(c,d,e,f)}throw H.e(new P.j4("Unsupported number of arguments for wrapped closure"))},null,null,24,0,null,9,10,11,12,13,14],
ap:function(a,b){var z
H.M(b)
if(a==null)return
z=a.$identity
if(!!z)return z
z=function(c,d,e){return function(f,g,h,i){return e(c,d,f,g,h,i)}}(a,b,H.kn)
a.$identity=z
return z},
f3:function(a,b,c,d,e,f,g){var z,y,x,w,v,u,t,s,r,q,p,o,n
z=b[0]
y=z.$callName
if(!!J.u(d).$ist){z.$reflectionInfo=d
x=H.dw(z).r}else x=d
w=e?Object.create(new H.ix().constructor.prototype):Object.create(new H.bW(null,null,null,null).constructor.prototype)
w.$initialize=w.constructor
if(e)v=function static_tear_off(){this.$initialize()}
else{u=$.a3
if(typeof u!=="number")return u.A()
$.a3=u+1
u=new Function("a,b,c,d"+u,"this.$initialize(a,b,c,d"+u+")")
v=u}w.constructor=v
v.prototype=w
if(!e){t=H.d_(a,z,f)
t.$reflectionInfo=d}else{w.$static_name=g
t=z}if(typeof x=="number")s=function(h,i){return function(){return h(i)}}(H.ke,x)
else if(typeof x=="function")if(e)s=x
else{r=f?H.cZ:H.bX
s=function(h,i){return function(){return h.apply({$receiver:i(this)},arguments)}}(x,r)}else throw H.e("Error in reflectionInfo.")
w.$S=s
w[y]=t
for(q=t,p=1;p<b.length;++p){o=b[p]
n=o.$callName
if(n!=null){o=e?o:H.d_(a,o,f)
w[n]=o}if(p===c){o.$reflectionInfo=d
q=o}}w["call*"]=q
w.$R=z.$R
w.$D=z.$D
return v},
f0:function(a,b,c,d){var z=H.bX
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,z)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,z)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,z)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,z)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,z)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,z)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,z)}},
d_:function(a,b,c){var z,y,x,w,v,u,t
if(c)return H.f2(a,b)
z=b.$stubName
y=b.length
x=a[z]
w=b==null?x==null:b===x
v=!w||y>=27
if(v)return H.f0(y,!w,z,b)
if(y===0){w=$.a3
if(typeof w!=="number")return w.A()
$.a3=w+1
u="self"+w
w="return function(){var "+u+" = this."
v=$.aL
if(v==null){v=H.bo("self")
$.aL=v}return new Function(w+H.f(v)+";return "+u+"."+H.f(z)+"();}")()}t="abcdefghijklmnopqrstuvwxyz".split("").splice(0,y).join(",")
w=$.a3
if(typeof w!=="number")return w.A()
$.a3=w+1
t+=w
w="return function("+t+"){return this."
v=$.aL
if(v==null){v=H.bo("self")
$.aL=v}return new Function(w+H.f(v)+"."+H.f(z)+"("+t+");}")()},
f1:function(a,b,c,d){var z,y
z=H.bX
y=H.cZ
switch(b?-1:a){case 0:throw H.e(H.iv("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,z,y)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,z,y)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,z,y)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,z,y)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,z,y)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,z,y)
default:return function(e,f,g,h){return function(){h=[g(this)]
Array.prototype.push.apply(h,arguments)
return e.apply(f(this),h)}}(d,z,y)}},
f2:function(a,b){var z,y,x,w,v,u,t,s
z=$.aL
if(z==null){z=H.bo("self")
$.aL=z}y=$.cY
if(y==null){y=H.bo("receiver")
$.cY=y}x=b.$stubName
w=b.length
v=a[x]
u=b==null?v==null:b===v
t=!u||w>=28
if(t)return H.f1(w,!u,x,b)
if(w===1){z="return function(){return this."+H.f(z)+"."+H.f(x)+"(this."+H.f(y)+");"
y=$.a3
if(typeof y!=="number")return y.A()
$.a3=y+1
return new Function(z+y+"}")()}s="abcdefghijklmnopqrstuvwxyz".split("").splice(0,w-1).join(",")
z="return function("+s+"){return this."+H.f(z)+"."+H.f(x)+"(this."+H.f(y)+", "+s+");"
y=$.a3
if(typeof y!=="number")return y.A()
$.a3=y+1
return new Function(z+y+"}")()},
cE:function(a,b,c,d,e,f,g){return H.f3(a,b,H.M(c),d,!!e,!!f,g)},
m:function(a){if(a==null)return a
if(typeof a==="string")return a
throw H.e(H.a0(a,"String"))},
l6:function(a){if(a==null)return a
if(typeof a==="number")return a
throw H.e(H.a0(a,"double"))},
kc:function(a){if(typeof a==="number"||a==null)return a
throw H.e(H.bY(a,"double"))},
b_:function(a){if(a==null)return a
if(typeof a==="number")return a
throw H.e(H.a0(a,"num"))},
cC:function(a){if(a==null)return a
if(typeof a==="boolean")return a
throw H.e(H.a0(a,"bool"))},
M:function(a){if(a==null)return a
if(typeof a==="number"&&Math.floor(a)===a)return a
throw H.e(H.a0(a,"int"))},
W:function(a){if(typeof a==="number"&&Math.floor(a)===a||a==null)return a
throw H.e(H.bY(a,"int"))},
ew:function(a,b){throw H.e(H.a0(a,H.aK(H.m(b).substring(3))))},
kz:function(a,b){throw H.e(H.bY(a,H.aK(H.m(b).substring(3))))},
d:function(a,b){if(a==null)return a
if((typeof a==="object"||typeof a==="function")&&J.u(a)[b])return a
H.ew(a,b)},
cK:function(a,b){var z
if(a!=null)z=(typeof a==="object"||typeof a==="function")&&J.u(a)[b]
else z=!0
if(z)return a
H.kz(a,b)},
aZ:function(a){if(a==null)return a
if(!!J.u(a).$ist)return a
throw H.e(H.a0(a,"List<dynamic>"))},
kr:function(a,b){var z
if(a==null)return a
z=J.u(a)
if(!!z.$ist)return a
if(z[b])return a
H.ew(a,b)},
ep:function(a){var z
if("$S" in a){z=a.$S
if(typeof z=="number")return init.types[H.M(z)]
else return a.$S()}return},
bc:function(a,b){var z
if(a==null)return!1
if(typeof a=="function")return!0
z=H.ep(J.u(a))
if(z==null)return!1
return H.eg(z,null,b,null)},
c:function(a,b){var z,y
if(a==null)return a
if($.cy)return a
$.cy=!0
try{if(H.bc(a,b))return a
z=H.bQ(b)
y=H.a0(a,z)
throw H.e(y)}finally{$.cy=!1}},
ad:function(a,b){if(a!=null&&!H.cD(a,b))H.S(H.a0(a,H.bQ(b)))
return a},
ek:function(a){var z,y
z=J.u(a)
if(!!z.$isa){y=H.ep(z)
if(y!=null)return H.bQ(y)
return"Closure"}return H.aS(a)},
kB:function(a){throw H.e(new P.ff(H.m(a)))},
cI:function(a){return init.getIsolateTag(a)},
y:function(a,b){a.$ti=b
return a},
ar:function(a){if(a==null)return
return a.$ti},
l7:function(a,b,c){return H.aJ(a["$as"+H.f(c)],H.ar(b))},
a7:function(a,b,c,d){var z
H.m(c)
H.M(d)
z=H.aJ(a["$as"+H.f(c)],H.ar(b))
return z==null?null:z[d]},
aY:function(a,b,c){var z
H.m(b)
H.M(c)
z=H.aJ(a["$as"+H.f(b)],H.ar(a))
return z==null?null:z[c]},
i:function(a,b){var z
H.M(b)
z=H.ar(a)
return z==null?null:z[b]},
bQ:function(a){return H.ao(a,null)},
ao:function(a,b){var z,y
H.V(b,"$ist",[P.h],"$ast")
if(a==null)return"dynamic"
if(a===-1)return"void"
if(typeof a==="object"&&a!==null&&a.constructor===Array)return H.aK(a[0].builtin$cls)+H.cB(a,1,b)
if(typeof a=="function")return H.aK(a.builtin$cls)
if(a===-2)return"dynamic"
if(typeof a==="number"){H.M(a)
if(b==null||a<0||a>=b.length)return"unexpected-generic-index:"+a
z=b.length
y=z-a-1
if(y<0||y>=z)return H.A(b,y)
return H.f(b[y])}if('func' in a)return H.jX(a,b)
if('futureOr' in a)return"FutureOr<"+H.ao("type" in a?a.type:null,b)+">"
return"unknown-reified-type"},
jX:function(a,b){var z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h
z=[P.h]
H.V(b,"$ist",z,"$ast")
if("bounds" in a){y=a.bounds
if(b==null){b=H.y([],z)
x=null}else x=b.length
w=b.length
for(v=y.length,u=v;u>0;--u)C.b.p(b,"T"+(w+u))
for(t="<",s="",u=0;u<v;++u,s=", "){t+=s
z=b.length
r=z-u-1
if(r<0)return H.A(b,r)
t=C.k.A(t,b[r])
q=y[u]
if(q!=null&&q!==P.b)t+=" extends "+H.ao(q,b)}t+=">"}else{t=""
x=null}p=!!a.v?"void":H.ao(a.ret,b)
if("args" in a){o=a.args
for(z=o.length,n="",m="",l=0;l<z;++l,m=", "){k=o[l]
n=n+m+H.ao(k,b)}}else{n=""
m=""}if("opt" in a){j=a.opt
n+=m+"["
for(z=j.length,m="",l=0;l<z;++l,m=", "){k=j[l]
n=n+m+H.ao(k,b)}n+="]"}if("named" in a){i=a.named
n+=m+"{"
for(z=H.kd(i),r=z.length,m="",l=0;l<r;++l,m=", "){h=H.m(z[l])
n=n+m+H.ao(i[h],b)+(" "+H.f(h))}n+="}"}if(x!=null)b.length=x
return t+"("+n+") => "+p},
cB:function(a,b,c){var z,y,x,w,v,u
H.V(c,"$ist",[P.h],"$ast")
if(a==null)return""
z=new P.bF("")
for(y=b,x="",w=!0,v="";y<a.length;++y,x=", "){z.a=v+x
u=a[y]
if(u!=null)w=!1
v=z.a+=H.ao(u,c)}return"<"+z.i(0)+">"},
aJ:function(a,b){if(a==null)return b
a=a.apply(null,b)
if(a==null)return
if(typeof a==="object"&&a!==null&&a.constructor===Array)return a
if(typeof a=="function")return a.apply(null,b)
return b},
aX:function(a,b,c,d){var z,y
H.m(b)
H.aZ(c)
H.m(d)
if(a==null)return!1
z=H.ar(a)
y=J.u(a)
if(y[b]==null)return!1
return H.en(H.aJ(y[d],z),null,c,null)},
V:function(a,b,c,d){H.m(b)
H.aZ(c)
H.m(d)
if(a==null)return a
if(H.aX(a,b,c,d))return a
throw H.e(H.a0(a,function(e,f){return e.replace(/[^<,> ]+/g,function(g){return f[g]||g})}(H.aK(b.substring(3))+H.cB(c,0,null),init.mangledGlobalNames)))},
en:function(a,b,c,d){var z,y
if(c==null)return!0
if(a==null){z=c.length
for(y=0;y<z;++y)if(!H.Z(null,null,c[y],d))return!1
return!0}z=a.length
for(y=0;y<z;++y)if(!H.Z(a[y],b,c[y],d))return!1
return!0},
l4:function(a,b,c){return a.apply(b,H.aJ(J.u(b)["$as"+H.f(c)],H.ar(b)))},
et:function(a){var z
if(typeof a==="number")return!1
if('futureOr' in a){z="type" in a?a.type:null
return a==null||a.builtin$cls==="b"||a.builtin$cls==="k"||a===-1||a===-2||H.et(z)}return!1},
cD:function(a,b){var z,y
if(a==null)return b==null||b.builtin$cls==="b"||b.builtin$cls==="k"||b===-1||b===-2||H.et(b)
if(b==null||b===-1||b.builtin$cls==="b"||b===-2)return!0
if(typeof b=="object"){if('futureOr' in b)if(H.cD(a,"type" in b?b.type:null))return!0
if('func' in b)return H.bc(a,b)}z=J.u(a).constructor
y=H.ar(a)
if(y!=null){y=y.slice()
y.splice(0,0,z)
z=y}return H.Z(z,null,b,null)},
l:function(a,b){if(a!=null&&!H.cD(a,b))throw H.e(H.a0(a,H.bQ(b)))
return a},
Z:function(a,b,c,d){var z,y,x,w,v,u,t,s,r
if(a===c)return!0
if(c==null||c===-1||c.builtin$cls==="b"||c===-2)return!0
if(a===-2)return!0
if(a==null||a===-1||a.builtin$cls==="b"||a===-2){if(typeof c==="number")return!1
if('futureOr' in c)return H.Z(a,b,"type" in c?c.type:null,d)
return!1}if(typeof a==="number")return!1
if(typeof c==="number")return!1
if(a.builtin$cls==="k")return!0
if('func' in c)return H.eg(a,b,c,d)
if('func' in a)return c.builtin$cls==="af"
z=typeof a==="object"&&a!==null&&a.constructor===Array
y=z?a[0]:a
if('futureOr' in c){x="type" in c?c.type:null
if('futureOr' in a)return H.Z("type" in a?a.type:null,b,x,d)
else if(H.Z(a,b,x,d))return!0
else{if(!('$is'+"H" in y.prototype))return!1
w=y.prototype["$as"+"H"]
v=H.aJ(w,z?a.slice(1):null)
return H.Z(typeof v==="object"&&v!==null&&v.constructor===Array?v[0]:null,b,x,d)}}u=typeof c==="object"&&c!==null&&c.constructor===Array
t=u?c[0]:c
if(t!==y){s=t.builtin$cls
if(!('$is'+s in y.prototype))return!1
r=y.prototype["$as"+s]}else r=null
if(!u)return!0
z=z?a.slice(1):null
u=c.slice(1)
return H.en(H.aJ(r,z),b,u,d)},
eg:function(a,b,c,d){var z,y,x,w,v,u,t,s,r,q,p,o,n,m,l
if(!('func' in a))return!1
if("bounds" in a){if(!("bounds" in c))return!1
z=a.bounds
y=c.bounds
if(z.length!==y.length)return!1}else if("bounds" in c)return!1
if(!H.Z(a.ret,b,c.ret,d))return!1
x=a.args
w=c.args
v=a.opt
u=c.opt
t=x!=null?x.length:0
s=w!=null?w.length:0
r=v!=null?v.length:0
q=u!=null?u.length:0
if(t>s)return!1
if(t+r<s+q)return!1
for(p=0;p<t;++p)if(!H.Z(w[p],d,x[p],b))return!1
for(o=p,n=0;o<s;++n,++o)if(!H.Z(w[o],d,v[n],b))return!1
for(o=0;o<q;++n,++o)if(!H.Z(u[o],d,v[n],b))return!1
m=a.named
l=c.named
if(l==null)return!0
if(m==null)return!1
return H.ku(m,b,l,d)},
ku:function(a,b,c,d){var z,y,x,w
z=Object.getOwnPropertyNames(c)
for(y=z.length,x=0;x<y;++x){w=z[x]
if(!Object.hasOwnProperty.call(a,w))return!1
if(!H.Z(c[w],d,a[w],b))return!1}return!0},
l5:function(a,b,c){Object.defineProperty(a,H.m(b),{value:c,enumerable:false,writable:true,configurable:true})},
ks:function(a){var z,y,x,w,v,u
z=H.m($.er.$1(a))
y=$.bM[z]
if(y!=null){Object.defineProperty(a,init.dispatchPropertyName,{value:y,enumerable:false,writable:true,configurable:true})
return y.i}x=$.bO[z]
if(x!=null)return x
w=init.interceptorsByTag[z]
if(w==null){z=H.m($.em.$2(a,z))
if(z!=null){y=$.bM[z]
if(y!=null){Object.defineProperty(a,init.dispatchPropertyName,{value:y,enumerable:false,writable:true,configurable:true})
return y.i}x=$.bO[z]
if(x!=null)return x
w=init.interceptorsByTag[z]}}if(w==null)return
x=w.prototype
v=z[0]
if(v==="!"){y=H.bP(x)
$.bM[z]=y
Object.defineProperty(a,init.dispatchPropertyName,{value:y,enumerable:false,writable:true,configurable:true})
return y.i}if(v==="~"){$.bO[z]=x
return x}if(v==="-"){u=H.bP(x)
Object.defineProperty(Object.getPrototypeOf(a),init.dispatchPropertyName,{value:u,enumerable:false,writable:true,configurable:true})
return u.i}if(v==="+")return H.ev(a,x)
if(v==="*")throw H.e(P.dU(z))
if(init.leafTags[z]===true){u=H.bP(x)
Object.defineProperty(Object.getPrototypeOf(a),init.dispatchPropertyName,{value:u,enumerable:false,writable:true,configurable:true})
return u.i}else return H.ev(a,x)},
ev:function(a,b){var z=Object.getPrototypeOf(a)
Object.defineProperty(z,init.dispatchPropertyName,{value:J.cL(b,z,null,null),enumerable:false,writable:true,configurable:true})
return b},
bP:function(a){return J.cL(a,!1,null,!!a.$isaa)},
kt:function(a,b,c){var z=b.prototype
if(init.leafTags[a]===true)return H.bP(z)
else return J.cL(z,c,null,null)},
kl:function(){if(!0===$.cJ)return
$.cJ=!0
H.km()},
km:function(){var z,y,x,w,v,u,t,s
$.bM=Object.create(null)
$.bO=Object.create(null)
H.kh()
z=init.interceptorsByTag
y=Object.getOwnPropertyNames(z)
if(typeof window!="undefined"){window
x=function(){}
for(w=0;w<y.length;++w){v=y[w]
u=$.ex.$1(v)
if(u!=null){t=H.kt(v,z[v],u)
if(t!=null){Object.defineProperty(u,init.dispatchPropertyName,{value:t,enumerable:false,writable:true,configurable:true})
x.prototype=u}}}}for(w=0;w<y.length;++w){v=y[w]
if(/^[A-Za-z_]/.test(v)){s=z[v]
z["!"+v]=s
z["~"+v]=s
z["-"+v]=s
z["+"+v]=s
z["*"+v]=s}}},
kh:function(){var z,y,x,w,v,u,t
z=C.M()
z=H.aG(C.J,H.aG(C.O,H.aG(C.w,H.aG(C.w,H.aG(C.N,H.aG(C.K,H.aG(C.L(C.x),z)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){y=dartNativeDispatchHooksTransformer
if(typeof y=="function")y=[y]
if(y.constructor==Array)for(x=0;x<y.length;++x){w=y[x]
if(typeof w=="function")z=w(z)||z}}v=z.getTag
u=z.getUnknownTag
t=z.prototypeForTag
$.er=new H.ki(v)
$.em=new H.kj(u)
$.ex=new H.kk(t)},
aG:function(a,b){return a(b)||b},
kA:function(a,b,c){var z=a.indexOf(b,c)
return z>=0},
f9:{"^":"iM;a,$ti"},
f8:{"^":"b;$ti",
i:function(a){return P.bC(this)},
n:function(a,b,c){H.l(b,H.i(this,0))
H.c(c,{func:1,ret:H.i(this,1)})
return H.fa()},
$isK:1},
fb:{"^":"f8;a,b,c,$ti",
gk:function(a){return this.a},
cl:function(a){return this.b[H.m(a)]},
q:function(a,b){var z,y,x,w,v
z=H.i(this,1)
H.c(b,{func:1,ret:-1,args:[H.i(this,0),z]})
y=this.c
for(x=y.length,w=0;w<x;++w){v=y[w]
b.$2(v,H.l(this.cl(v),z))}}},
h3:{"^":"b;a,b,c,d,e,f",
gbB:function(){var z=this.a
return z},
gbE:function(){var z,y,x,w
if(this.c===1)return C.y
z=this.d
y=z.length-this.e.length-this.f
if(y===0)return C.y
x=[]
for(w=0;w<y;++w){if(w>=z.length)return H.A(z,w)
x.push(z[w])}x.fixed$length=Array
x.immutable$list=Array
return x},
gbC:function(){var z,y,x,w,v,u,t,s,r
if(this.c!==0)return C.z
z=this.e
y=z.length
x=this.d
w=x.length-y-this.f
if(y===0)return C.z
v=P.aA
u=new H.b5(0,0,[v,null])
for(t=0;t<y;++t){if(t>=z.length)return H.A(z,t)
s=z[t]
r=w+t
if(r<0||r>=x.length)return H.A(x,r)
u.D(0,new H.cm(s),x[r])}return new H.f9(u,[v,null])},
$isc5:1},
it:{"^":"b;a,b,c,d,e,f,r,0x",
d2:function(a,b){var z=this.d
if(typeof b!=="number")return b.Z()
if(b<z)return
return this.b[3+b-z]},
m:{
dw:function(a){var z,y,x
z=a.$reflectionInfo
if(z==null)return
z=J.bv(z)
y=z[0]
x=z[1]
return new H.it(a,z,(y&2)===2,y>>2,x>>1,(x&1)===1,z[2])}}},
ii:{"^":"a:54;a,b,c",
$2:function(a,b){var z
H.m(a)
z=this.a
z.b=z.b+"$"+H.f(a)
C.b.p(this.b,a)
C.b.p(this.c,b);++z.a}},
iI:{"^":"b;a,b,c,d,e,f",
P:function(a){var z,y,x
z=new RegExp(this.a).exec(a)
if(z==null)return
y=Object.create(null)
x=this.b
if(x!==-1)y.arguments=z[x+1]
x=this.c
if(x!==-1)y.argumentsExpr=z[x+1]
x=this.d
if(x!==-1)y.expr=z[x+1]
x=this.e
if(x!==-1)y.method=z[x+1]
x=this.f
if(x!==-1)y.receiver=z[x+1]
return y},
m:{
a6:function(a){var z,y,x,w,v,u
a=a.replace(String({}),'$receiver$').replace(/[[\]{}()*+?.\\^$|]/g,"\\$&")
z=a.match(/\\\$[a-zA-Z]+\\\$/g)
if(z==null)z=H.y([],[P.h])
y=z.indexOf("\\$arguments\\$")
x=z.indexOf("\\$argumentsExpr\\$")
w=z.indexOf("\\$expr\\$")
v=z.indexOf("\\$method\\$")
u=z.indexOf("\\$receiver\\$")
return new H.iI(a.replace(new RegExp('\\\\\\$arguments\\\\\\$','g'),'((?:x|[^x])*)').replace(new RegExp('\\\\\\$argumentsExpr\\\\\\$','g'),'((?:x|[^x])*)').replace(new RegExp('\\\\\\$expr\\\\\\$','g'),'((?:x|[^x])*)').replace(new RegExp('\\\\\\$method\\\\\\$','g'),'((?:x|[^x])*)').replace(new RegExp('\\\\\\$receiver\\\\\\$','g'),'((?:x|[^x])*)'),y,x,w,v,u)},
bG:function(a){return function($expr$){var $argumentsExpr$='$arguments$'
try{$expr$.$method$($argumentsExpr$)}catch(z){return z.message}}(a)},
dN:function(a){return function($expr$){try{$expr$.$method$}catch(z){return z.message}}(a)}}},
ib:{"^":"L;a,b",
i:function(a){var z=this.b
if(z==null)return"NoSuchMethodError: "+H.f(this.a)
return"NoSuchMethodError: method not found: '"+z+"' on null"},
m:{
ds:function(a,b){return new H.ib(a,b==null?null:b.method)}}},
h9:{"^":"L;a,b,c",
i:function(a){var z,y
z=this.b
if(z==null)return"NoSuchMethodError: "+H.f(this.a)
y=this.c
if(y==null)return"NoSuchMethodError: method not found: '"+z+"' ("+H.f(this.a)+")"
return"NoSuchMethodError: method not found: '"+z+"' on '"+y+"' ("+H.f(this.a)+")"},
m:{
cc:function(a,b){var z,y
z=b==null
y=z?null:b.method
return new H.h9(a,y,z?null:b.receiver)}}},
iL:{"^":"L;a",
i:function(a){var z=this.a
return z.length===0?"Error":"Error: "+z}},
c2:{"^":"b;a,b"},
kC:{"^":"a:6;a",
$1:function(a){if(!!J.u(a).$isL)if(a.$thrownJsError==null)a.$thrownJsError=this.a
return a}},
e9:{"^":"b;a,0b",
i:function(a){var z,y
z=this.b
if(z!=null)return z
z=this.a
y=z!==null&&typeof z==="object"?z.stack:null
z=y==null?"":y
this.b=z
return z},
$isO:1},
a:{"^":"b;",
i:function(a){return"Closure '"+H.aS(this).trim()+"'"},
gbJ:function(){return this},
$isaf:1,
gbJ:function(){return this}},
dE:{"^":"a;"},
ix:{"^":"dE;",
i:function(a){var z=this.$static_name
if(z==null)return"Closure of unknown static method"
return"Closure '"+H.aK(z)+"'"}},
bW:{"^":"dE;a,b,c,d",
T:function(a,b){if(b==null)return!1
if(this===b)return!0
if(!(b instanceof H.bW))return!1
return this.a===b.a&&this.b===b.b&&this.c===b.c},
gE:function(a){var z,y
z=this.c
if(z==null)y=H.aR(this.a)
else y=typeof z!=="object"?J.bj(z):H.aR(z)
return(y^H.aR(this.b))>>>0},
i:function(a){var z=this.c
if(z==null)z=this.a
return"Closure '"+H.f(this.d)+"' of "+("Instance of '"+H.aS(z)+"'")},
m:{
bX:function(a){return a.a},
cZ:function(a){return a.c},
bo:function(a){var z,y,x,w,v
z=new H.bW("self","target","receiver","name")
y=J.bv(Object.getOwnPropertyNames(z))
for(x=y.length,w=0;w<x;++w){v=y[w]
if(z[v]===a)return v}}}},
iJ:{"^":"L;a",
i:function(a){return this.a},
m:{
a0:function(a,b){return new H.iJ("TypeError: "+H.f(P.aw(a))+": type '"+H.ek(a)+"' is not a subtype of type '"+b+"'")}}},
f_:{"^":"L;a",
i:function(a){return this.a},
m:{
bY:function(a,b){return new H.f_("CastError: "+H.f(P.aw(a))+": type '"+H.ek(a)+"' is not a subtype of type '"+b+"'")}}},
iu:{"^":"L;a",
i:function(a){return"RuntimeError: "+H.f(this.a)},
m:{
iv:function(a){return new H.iu(a)}}},
b5:{"^":"ce;a,0b,0c,0d,0e,0f,r,$ti",
gk:function(a){return this.a},
gbz:function(a){return this.a===0},
gI:function(a){return new H.hW(this,[H.i(this,0)])},
G:function(a,b){var z,y
if(typeof b==="string"){z=this.b
if(z==null)return!1
return this.bb(z,b)}else if(typeof b==="number"&&(b&0x3ffffff)===b){y=this.c
if(y==null)return!1
return this.bb(y,b)}else return this.d6(b)},
d6:function(a){var z=this.d
if(z==null)return!1
return this.ao(this.ai(z,this.an(a)),a)>=0},
l:function(a,b){var z,y,x,w
if(typeof b==="string"){z=this.b
if(z==null)return
y=this.a8(z,b)
x=y==null?null:y.b
return x}else if(typeof b==="number"&&(b&0x3ffffff)===b){w=this.c
if(w==null)return
y=this.a8(w,b)
x=y==null?null:y.b
return x}else return this.d7(b)},
d7:function(a){var z,y,x
z=this.d
if(z==null)return
y=this.ai(z,this.an(a))
x=this.ao(y,a)
if(x<0)return
return y[x].b},
D:function(a,b,c){var z,y
H.l(b,H.i(this,0))
H.l(c,H.i(this,1))
if(typeof b==="string"){z=this.b
if(z==null){z=this.aG()
this.b=z}this.b3(z,b,c)}else if(typeof b==="number"&&(b&0x3ffffff)===b){y=this.c
if(y==null){y=this.aG()
this.c=y}this.b3(y,b,c)}else this.d9(b,c)},
d9:function(a,b){var z,y,x,w
H.l(a,H.i(this,0))
H.l(b,H.i(this,1))
z=this.d
if(z==null){z=this.aG()
this.d=z}y=this.an(a)
x=this.ai(z,y)
if(x==null)this.aI(z,y,[this.ay(a,b)])
else{w=this.ao(x,a)
if(w>=0)x[w].b=b
else x.push(this.ay(a,b))}},
n:function(a,b,c){var z
H.l(b,H.i(this,0))
H.c(c,{func:1,ret:H.i(this,1)})
if(this.G(0,b))return this.l(0,b)
z=c.$0()
this.D(0,b,z)
return z},
R:function(a,b){if(typeof b==="string")return this.bk(this.b,b)
else if(typeof b==="number"&&(b&0x3ffffff)===b)return this.bk(this.c,b)
else return this.d8(b)},
d8:function(a){var z,y,x,w
z=this.d
if(z==null)return
y=this.ai(z,this.an(a))
x=this.ao(y,a)
if(x<0)return
w=y.splice(x,1)[0]
this.bo(w)
return w.b},
q:function(a,b){var z,y
H.c(b,{func:1,ret:-1,args:[H.i(this,0),H.i(this,1)]})
z=this.e
y=this.r
for(;z!=null;){b.$2(z.a,z.b)
if(y!==this.r)throw H.e(P.a4(this))
z=z.c}},
b3:function(a,b,c){var z
H.l(b,H.i(this,0))
H.l(c,H.i(this,1))
z=this.a8(a,b)
if(z==null)this.aI(a,b,this.ay(b,c))
else z.b=c},
bk:function(a,b){var z
if(a==null)return
z=this.a8(a,b)
if(z==null)return
this.bo(z)
this.bd(a,b)
return z.b},
b5:function(){this.r=this.r+1&67108863},
ay:function(a,b){var z,y
z=new H.hV(H.l(a,H.i(this,0)),H.l(b,H.i(this,1)))
if(this.e==null){this.f=z
this.e=z}else{y=this.f
z.d=y
y.c=z
this.f=z}++this.a
this.b5()
return z},
bo:function(a){var z,y
z=a.d
y=a.c
if(z==null)this.e=y
else z.c=y
if(y==null)this.f=z
else y.d=z;--this.a
this.b5()},
an:function(a){return J.bj(a)&0x3ffffff},
ao:function(a,b){var z,y
if(a==null)return-1
z=a.length
for(y=0;y<z;++y)if(J.bg(a[y].a,b))return y
return-1},
i:function(a){return P.bC(this)},
a8:function(a,b){return a[b]},
ai:function(a,b){return a[b]},
aI:function(a,b,c){a[b]=c},
bd:function(a,b){delete a[b]},
bb:function(a,b){return this.a8(a,b)!=null},
aG:function(){var z=Object.create(null)
this.aI(z,"<non-identifier-key>",z)
this.bd(z,"<non-identifier-key>")
return z}},
hV:{"^":"b;a,b,0c,0d"},
hW:{"^":"c0;a,$ti",
gk:function(a){return this.a.a},
gB:function(a){var z,y
z=this.a
y=new H.hX(z,z.r,this.$ti)
y.c=z.e
return y},
v:function(a,b){return this.a.G(0,b)}},
hX:{"^":"b;a,b,0c,0d,$ti",
sb4:function(a){this.d=H.l(a,H.i(this,0))},
gw:function(){return this.d},
t:function(){var z=this.a
if(this.b!==z.r)throw H.e(P.a4(z))
else{z=this.c
if(z==null){this.sb4(null)
return!1}else{this.sb4(z.a)
this.c=this.c.c
return!0}}},
$isah:1},
ki:{"^":"a:6;a",
$1:function(a){return this.a(a)}},
kj:{"^":"a:45;a",
$2:function(a,b){return this.a(a,b)}},
kk:{"^":"a:23;a",
$1:function(a){return this.a(H.m(a))}},
h7:{"^":"b;a,b,0c,0d",
i:function(a){return"RegExp/"+this.a+"/"},
$isdt:1,
m:{
h8:function(a,b,c,d){var z,y,x,w
z=b?"m":""
y=c?"":"i"
x=d?"g":""
w=function(e,f){try{return new RegExp(e,f)}catch(v){return v}}(a,z+y+x)
if(w instanceof RegExp)return w
throw H.e(P.c3("Illegal RegExp pattern ("+String(w)+")",a,null))}}}}],["","",,H,{"^":"",
kd:function(a){return J.h1(a?Object.keys(a):[],null)}}],["","",,H,{"^":"",
kv:function(a){if(typeof dartPrint=="function"){dartPrint(a)
return}if(typeof console=="object"&&typeof console.log!="undefined"){console.log(a)
return}if(typeof window=="object")return
if(typeof print=="function"){print(a)
return}throw"Unable to print message: "+String(a)}}],["","",,H,{"^":"",
an:function(a,b,c){if(a>>>0!==a||a>=c)throw H.e(H.aq(b,a))},
i5:{"^":"x;",$isdS:1,"%":"DataView;ArrayBufferView;cf|e5|e6|i4|e7|e8|al"},
cf:{"^":"i5;",
gk:function(a){return a.length},
$isaa:1,
$asaa:I.cG},
i4:{"^":"e6;",
l:function(a,b){H.an(b,a,a.length)
return a[b]},
$asbu:function(){return[P.aI]},
$asI:function(){return[P.aI]},
$isp:1,
$asp:function(){return[P.aI]},
$ist:1,
$ast:function(){return[P.aI]},
"%":"Float32Array|Float64Array"},
al:{"^":"e8;",
$asbu:function(){return[P.w]},
$asI:function(){return[P.w]},
$isp:1,
$asp:function(){return[P.w]},
$ist:1,
$ast:function(){return[P.w]}},
kK:{"^":"al;",
l:function(a,b){H.an(b,a,a.length)
return a[b]},
"%":"Int16Array"},
kL:{"^":"al;",
l:function(a,b){H.an(b,a,a.length)
return a[b]},
"%":"Int32Array"},
kM:{"^":"al;",
l:function(a,b){H.an(b,a,a.length)
return a[b]},
"%":"Int8Array"},
kN:{"^":"al;",
l:function(a,b){H.an(b,a,a.length)
return a[b]},
"%":"Uint16Array"},
kO:{"^":"al;",
l:function(a,b){H.an(b,a,a.length)
return a[b]},
"%":"Uint32Array"},
kP:{"^":"al;",
gk:function(a){return a.length},
l:function(a,b){H.an(b,a,a.length)
return a[b]},
"%":"CanvasPixelArray|Uint8ClampedArray"},
kQ:{"^":"al;",
gk:function(a){return a.length},
l:function(a,b){H.an(b,a,a.length)
return a[b]},
"%":";Uint8Array"},
e5:{"^":"cf+I;"},
e6:{"^":"e5+bu;"},
e7:{"^":"cf+I;"},
e8:{"^":"e7+bu;"}}],["","",,P,{"^":"",
iR:function(){var z,y,x
z={}
if(self.scheduleImmediate!=null)return P.k9()
if(self.MutationObserver!=null&&self.document!=null){y=self.document.createElement("div")
x=self.document.createElement("span")
z.a=null
new self.MutationObserver(H.ap(new P.iT(z),1)).observe(y,{childList:true})
return new P.iS(z,y,x)}else if(self.setImmediate!=null)return P.ka()
return P.kb()},
kY:[function(a){self.scheduleImmediate(H.ap(new P.iU(H.c(a,{func:1,ret:-1})),0))},"$1","k9",4,0,10],
kZ:[function(a){self.setImmediate(H.ap(new P.iV(H.c(a,{func:1,ret:-1})),0))},"$1","ka",4,0,10],
l_:[function(a){P.cn(C.F,H.c(a,{func:1,ret:-1}))},"$1","kb",4,0,10],
cn:function(a,b){var z
H.c(b,{func:1,ret:-1})
z=C.f.ab(a.a,1000)
return P.jG(z<0?0:z,b)},
dG:function(a,b){var z
H.c(b,{func:1,ret:-1,args:[P.aB]})
z=C.f.ab(a.a,1000)
return P.jH(z<0?0:z,b)},
F:function(a){return new P.dW(new P.jD(new P.P(0,$.q,[a]),[a]),!1,[a])},
E:function(a,b){H.c(a,{func:1,ret:-1,args:[P.w,,]})
H.d(b,"$isdW")
a.$2(0,null)
b.b=!0
return b.a.a},
bb:function(a,b){P.jQ(a,H.c(b,{func:1,ret:-1,args:[P.w,,]}))},
D:function(a,b){H.d(b,"$isbZ").W(0,a)},
C:function(a,b){H.d(b,"$isbZ").ad(H.N(a),H.as(a))},
jQ:function(a,b){var z,y,x,w,v
H.c(b,{func:1,ret:-1,args:[P.w,,]})
z=new P.jR(b)
y=new P.jS(b)
x=J.u(a)
if(!!x.$isP)a.aJ(H.c(z,{func:1,ret:{futureOr:1},args:[,]}),y,null)
else{w={func:1,ret:{futureOr:1},args:[,]}
if(!!x.$isH)a.aq(H.c(z,w),y,null)
else{v=new P.P(0,$.q,[null])
H.l(a,null)
v.a=4
v.c=a
v.aJ(H.c(z,w),null,null)}}},
G:function(a){var z=function(b,c){return function(d,e){while(true)try{b(d,e)
break}catch(y){e=y
d=c}}}(a,1)
return $.q.bF(new P.k4(z),P.k,P.w,null)},
aO:function(a,b,c){var z
H.c(b,{func:1,ret:{futureOr:1,type:c}})
z=new P.P(0,$.q,[c])
P.iG(a,new P.fO(z,b))
return z},
k0:function(a,b){if(H.bc(a,{func:1,args:[P.b,P.O]}))return b.bF(a,null,P.b,P.O)
if(H.bc(a,{func:1,args:[P.b]})){b.toString
return H.c(a,{func:1,ret:null,args:[P.b]})}throw H.e(P.bl(a,"onError","Error handler must accept one Object or one Object and a StackTrace as arguments, and return a a valid result"))},
jZ:function(){var z,y
for(;z=$.aE,z!=null;){$.aV=null
y=z.b
$.aE=y
if(y==null)$.aU=null
z.a.$0()}},
l3:[function(){$.cz=!0
try{P.jZ()}finally{$.aV=null
$.cz=!1
if($.aE!=null)$.$get$cq().$1(P.eo())}},"$0","eo",0,0,4],
ej:function(a){var z=new P.dX(H.c(a,{func:1,ret:-1}))
if($.aE==null){$.aU=z
$.aE=z
if(!$.cz)$.$get$cq().$1(P.eo())}else{$.aU.b=z
$.aU=z}},
k3:function(a){var z,y,x
H.c(a,{func:1,ret:-1})
z=$.aE
if(z==null){P.ej(a)
$.aV=$.aU
return}y=new P.dX(a)
x=$.aV
if(x==null){y.b=z
$.aV=y
$.aE=y}else{y.b=x.b
x.b=y
$.aV=y
if(y.b==null)$.aU=y}},
cN:function(a){var z,y
z={func:1,ret:-1}
H.c(a,z)
y=$.q
if(C.i===y){P.aF(null,null,C.i,a)
return}y.toString
P.aF(null,null,y,H.c(y.aP(a),z))},
kT:function(a,b){return new P.jB(H.V(a,"$isck",[b],"$asck"),!1,[b])},
iG:function(a,b){var z,y
z={func:1,ret:-1}
H.c(b,z)
y=$.q
if(y===C.i){y.toString
return P.cn(a,b)}return P.cn(a,H.c(y.aP(b),z))},
iH:function(a,b){var z,y,x
z={func:1,ret:-1,args:[P.aB]}
H.c(b,z)
y=$.q
if(y===C.i){y.toString
return P.dG(a,b)}x=y.bq(b,P.aB)
$.q.toString
return P.dG(a,H.c(x,z))},
bL:function(a,b,c,d,e){var z={}
z.a=d
P.k3(new P.k1(z,e))},
eh:function(a,b,c,d,e){var z,y
H.c(d,{func:1,ret:e})
y=$.q
if(y===c)return d.$0()
$.q=c
z=y
try{y=d.$0()
return y}finally{$.q=z}},
ei:function(a,b,c,d,e,f,g){var z,y
H.c(d,{func:1,ret:f,args:[g]})
H.l(e,g)
y=$.q
if(y===c)return d.$1(e)
$.q=c
z=y
try{y=d.$1(e)
return y}finally{$.q=z}},
k2:function(a,b,c,d,e,f,g,h,i){var z,y
H.c(d,{func:1,ret:g,args:[h,i]})
H.l(e,h)
H.l(f,i)
y=$.q
if(y===c)return d.$2(e,f)
$.q=c
z=y
try{y=d.$2(e,f)
return y}finally{$.q=z}},
aF:function(a,b,c,d){var z
H.c(d,{func:1,ret:-1})
z=C.i!==c
if(z){if(z){c.toString
z=!1}else z=!0
d=!z?c.aP(d):c.cS(d,-1)}P.ej(d)},
iT:{"^":"a:2;a",
$1:[function(a){var z,y
z=this.a
y=z.a
z.a=null
y.$0()},null,null,4,0,null,15,"call"]},
iS:{"^":"a:53;a,b,c",
$1:function(a){var z,y
this.a.a=H.c(a,{func:1,ret:-1})
z=this.b
y=this.c
z.firstChild?z.removeChild(y):z.appendChild(y)}},
iU:{"^":"a:1;a",
$0:[function(){this.a.$0()},null,null,0,0,null,"call"]},
iV:{"^":"a:1;a",
$0:[function(){this.a.$0()},null,null,0,0,null,"call"]},
eb:{"^":"b;a,0b,c",
c5:function(a,b){if(self.setTimeout!=null)this.b=self.setTimeout(H.ap(new P.jJ(this,b),0),a)
else throw H.e(P.Q("`setTimeout()` not found."))},
c6:function(a,b){if(self.setTimeout!=null)this.b=self.setInterval(H.ap(new P.jI(this,a,Date.now(),b),0),a)
else throw H.e(P.Q("Periodic timer."))},
aQ:function(){if(self.setTimeout!=null){var z=this.b
if(z==null)return
if(this.a)self.clearTimeout(z)
else self.clearInterval(z)
this.b=null}else throw H.e(P.Q("Canceling a timer."))},
$isaB:1,
m:{
jG:function(a,b){var z=new P.eb(!0,0)
z.c5(a,b)
return z},
jH:function(a,b){var z=new P.eb(!1,0)
z.c6(a,b)
return z}}},
jJ:{"^":"a:4;a,b",
$0:[function(){var z=this.a
z.b=null
z.c=1
this.b.$0()},null,null,0,0,null,"call"]},
jI:{"^":"a:1;a,b,c,d",
$0:[function(){var z,y,x,w
z=this.a
y=z.c+1
x=this.b
if(x>0){w=Date.now()-this.c
if(w>(y+1)*x)y=C.f.c0(w,x)}z.c=y
this.d.$1(z)},null,null,0,0,null,"call"]},
dW:{"^":"b;a,b,$ti",
W:function(a,b){var z
H.ad(b,{futureOr:1,type:H.i(this,0)})
if(this.b)this.a.W(0,b)
else if(H.aX(b,"$isH",this.$ti,"$asH")){z=this.a
b.aq(z.gcV(z),z.gbv(),-1)}else P.cN(new P.iQ(this,b))},
ad:function(a,b){if(this.b)this.a.ad(a,b)
else P.cN(new P.iP(this,a,b))},
$isbZ:1},
iQ:{"^":"a:1;a,b",
$0:function(){this.a.a.W(0,this.b)}},
iP:{"^":"a:1;a,b,c",
$0:function(){this.a.a.ad(this.b,this.c)}},
jR:{"^":"a:7;a",
$1:function(a){return this.a.$2(0,a)}},
jS:{"^":"a:18;a",
$2:[function(a,b){this.a.$2(1,new H.c2(a,H.d(b,"$isO")))},null,null,8,0,null,0,1,"call"]},
k4:{"^":"a:24;a",
$2:function(a,b){this.a(H.M(a),b)}},
H:{"^":"b;$ti"},
fO:{"^":"a:1;a,b",
$0:function(){var z,y,x,w,v
try{x=this.b.$0()
this.a.ah(x)}catch(w){z=H.N(w)
y=H.as(w)
x=$.q
v=H.d(y,"$isO")
x.toString
this.a.V(z,v)}}},
e_:{"^":"b;$ti",
ad:[function(a,b){H.d(b,"$isO")
if(a==null)a=new P.cg()
if(this.a.a!==0)throw H.e(P.aT("Future already completed"))
$.q.toString
this.V(a,b)},function(a){return this.ad(a,null)},"bw","$2","$1","gbv",4,2,32,2,0,1],
$isbZ:1},
dY:{"^":"e_;a,$ti",
W:function(a,b){var z
H.ad(b,{futureOr:1,type:H.i(this,0)})
z=this.a
if(z.a!==0)throw H.e(P.aT("Future already completed"))
z.c9(b)},
V:function(a,b){this.a.ca(a,b)}},
jD:{"^":"e_;a,$ti",
W:[function(a,b){var z
H.ad(b,{futureOr:1,type:H.i(this,0)})
z=this.a
if(z.a!==0)throw H.e(P.aT("Future already completed"))
z.ah(b)},function(a){return this.W(a,null)},"dE","$1","$0","gcV",1,2,39],
V:function(a,b){this.a.V(a,b)}},
aC:{"^":"b;0a,b,c,d,e,$ti",
dk:function(a){if(this.c!==6)return!0
return this.b.b.aV(H.c(this.d,{func:1,ret:P.z,args:[P.b]}),a.a,P.z,P.b)},
d5:function(a){var z,y,x,w
z=this.e
y=P.b
x={futureOr:1,type:H.i(this,1)}
w=this.b.b
if(H.bc(z,{func:1,args:[P.b,P.O]}))return H.ad(w.du(z,a.a,a.b,null,y,P.O),x)
else return H.ad(w.aV(H.c(z,{func:1,args:[P.b]}),a.a,null,y),x)}},
P:{"^":"b;bm:a<,b,0cD:c<,$ti",
aq:function(a,b,c){var z,y
z=H.i(this,0)
H.c(a,{func:1,ret:{futureOr:1,type:c},args:[z]})
y=$.q
if(y!==C.i){y.toString
H.c(a,{func:1,ret:{futureOr:1,type:c},args:[z]})
if(b!=null)b=P.k0(b,y)}return this.aJ(a,b,c)},
N:function(a,b){return this.aq(a,null,b)},
aJ:function(a,b,c){var z,y,x
z=H.i(this,0)
H.c(a,{func:1,ret:{futureOr:1,type:c},args:[z]})
y=new P.P(0,$.q,[c])
x=b==null?1:3
this.b7(new P.aC(y,x,a,b,[z,c]))
return y},
b7:function(a){var z,y
z=this.a
if(z<=1){a.a=H.d(this.c,"$isaC")
this.c=a}else{if(z===2){y=H.d(this.c,"$isP")
z=y.a
if(z<4){y.b7(a)
return}this.a=z
this.c=y.c}z=this.b
z.toString
P.aF(null,null,z,H.c(new P.j5(this,a),{func:1,ret:-1}))}},
bi:function(a){var z,y,x,w,v,u
z={}
z.a=a
if(a==null)return
y=this.a
if(y<=1){x=H.d(this.c,"$isaC")
this.c=a
if(x!=null){for(w=a;v=w.a,v!=null;w=v);w.a=x}}else{if(y===2){u=H.d(this.c,"$isP")
y=u.a
if(y<4){u.bi(a)
return}this.a=y
this.c=u.c}z.a=this.al(a)
y=this.b
y.toString
P.aF(null,null,y,H.c(new P.jc(z,this),{func:1,ret:-1}))}},
ak:function(){var z=H.d(this.c,"$isaC")
this.c=null
return this.al(z)},
al:function(a){var z,y,x
for(z=a,y=null;z!=null;y=z,z=x){x=z.a
z.a=y}return y},
ah:function(a){var z,y,x
z=H.i(this,0)
H.ad(a,{futureOr:1,type:z})
y=this.$ti
if(H.aX(a,"$isH",y,"$asH"))if(H.aX(a,"$isP",y,null))P.bI(a,this)
else P.e1(a,this)
else{x=this.ak()
H.l(a,z)
this.a=4
this.c=a
P.aD(this,x)}},
V:function(a,b){var z
H.d(b,"$isO")
z=this.ak()
this.a=8
this.c=new P.X(a,b)
P.aD(this,z)},
c9:function(a){var z
H.ad(a,{futureOr:1,type:H.i(this,0)})
if(H.aX(a,"$isH",this.$ti,"$asH")){this.cc(a)
return}this.a=1
z=this.b
z.toString
P.aF(null,null,z,H.c(new P.j7(this,a),{func:1,ret:-1}))},
cc:function(a){var z=this.$ti
H.V(a,"$isH",z,"$asH")
if(H.aX(a,"$isP",z,null)){if(a.a===8){this.a=1
z=this.b
z.toString
P.aF(null,null,z,H.c(new P.jb(this,a),{func:1,ret:-1}))}else P.bI(a,this)
return}P.e1(a,this)},
ca:function(a,b){var z
this.a=1
z=this.b
z.toString
P.aF(null,null,z,H.c(new P.j6(this,a,b),{func:1,ret:-1}))},
$isH:1,
m:{
e1:function(a,b){var z,y,x
b.a=1
try{a.aq(new P.j8(b),new P.j9(b),null)}catch(x){z=H.N(x)
y=H.as(x)
P.cN(new P.ja(b,z,y))}},
bI:function(a,b){var z,y
for(;z=a.a,z===2;)a=H.d(a.c,"$isP")
if(z>=4){y=b.ak()
b.a=a.a
b.c=a.c
P.aD(b,y)}else{y=H.d(b.c,"$isaC")
b.a=2
b.c=a
a.bi(y)}},
aD:function(a,b){var z,y,x,w,v,u,t,s,r,q,p,o,n,m
z={}
z.a=a
for(y=a;!0;){x={}
w=y.a===8
if(b==null){if(w){v=H.d(y.c,"$isX")
y=y.b
u=v.a
t=v.b
y.toString
P.bL(null,null,y,u,t)}return}for(;s=b.a,s!=null;b=s){b.a=null
P.aD(z.a,b)}y=z.a
r=y.c
x.a=w
x.b=r
u=!w
if(u){t=b.c
t=(t&1)!==0||t===8}else t=!0
if(t){t=b.b
q=t.b
if(w){p=y.b
p.toString
p=p==null?q==null:p===q
if(!p)q.toString
else p=!0
p=!p}else p=!1
if(p){H.d(r,"$isX")
y=y.b
u=r.a
t=r.b
y.toString
P.bL(null,null,y,u,t)
return}o=$.q
if(o==null?q!=null:o!==q)$.q=q
else o=null
y=b.c
if(y===8)new P.jf(z,x,b,w).$0()
else if(u){if((y&1)!==0)new P.je(x,b,r).$0()}else if((y&2)!==0)new P.jd(z,x,b).$0()
if(o!=null)$.q=o
y=x.b
if(!!J.u(y).$isH){if(y.a>=4){n=H.d(t.c,"$isaC")
t.c=null
b=t.al(n)
t.a=y.a
t.c=y.c
z.a=y
continue}else P.bI(y,t)
return}}m=b.b
n=H.d(m.c,"$isaC")
m.c=null
b=m.al(n)
y=x.a
u=x.b
if(!y){H.l(u,H.i(m,0))
m.a=4
m.c=u}else{H.d(u,"$isX")
m.a=8
m.c=u}z.a=m
y=m}}}},
j5:{"^":"a:1;a,b",
$0:function(){P.aD(this.a,this.b)}},
jc:{"^":"a:1;a,b",
$0:function(){P.aD(this.b,this.a.a)}},
j8:{"^":"a:2;a",
$1:function(a){var z=this.a
z.a=0
z.ah(a)}},
j9:{"^":"a:40;a",
$2:[function(a,b){this.a.V(a,H.d(b,"$isO"))},function(a){return this.$2(a,null)},"$1",null,null,null,4,2,null,2,0,1,"call"]},
ja:{"^":"a:1;a,b,c",
$0:function(){this.a.V(this.b,this.c)}},
j7:{"^":"a:1;a,b",
$0:function(){var z,y,x
z=this.a
y=H.l(this.b,H.i(z,0))
x=z.ak()
z.a=4
z.c=y
P.aD(z,x)}},
jb:{"^":"a:1;a,b",
$0:function(){P.bI(this.b,this.a)}},
j6:{"^":"a:1;a,b,c",
$0:function(){this.a.V(this.b,this.c)}},
jf:{"^":"a:4;a,b,c,d",
$0:function(){var z,y,x,w,v,u,t
z=null
try{w=this.c
z=w.b.b.bG(H.c(w.d,{func:1}),null)}catch(v){y=H.N(v)
x=H.as(v)
if(this.d){w=H.d(this.a.a.c,"$isX").a
u=y
u=w==null?u==null:w===u
w=u}else w=!1
u=this.b
if(w)u.b=H.d(this.a.a.c,"$isX")
else u.b=new P.X(y,x)
u.a=!0
return}if(!!J.u(z).$isH){if(z instanceof P.P&&z.gbm()>=4){if(z.gbm()===8){w=this.b
w.b=H.d(z.gcD(),"$isX")
w.a=!0}return}t=this.a.a
w=this.b
w.b=z.N(new P.jg(t),null)
w.a=!1}}},
jg:{"^":"a:42;a",
$1:function(a){return this.a}},
je:{"^":"a:4;a,b,c",
$0:function(){var z,y,x,w,v,u,t
try{x=this.b
x.toString
w=H.i(x,0)
v=H.l(this.c,w)
u=H.i(x,1)
this.a.b=x.b.b.aV(H.c(x.d,{func:1,ret:{futureOr:1,type:u},args:[w]}),v,{futureOr:1,type:u},w)}catch(t){z=H.N(t)
y=H.as(t)
x=this.a
x.b=new P.X(z,y)
x.a=!0}}},
jd:{"^":"a:4;a,b,c",
$0:function(){var z,y,x,w,v,u,t,s
try{z=H.d(this.a.a.c,"$isX")
w=this.c
if(w.dk(z)&&w.e!=null){v=this.b
v.b=w.d5(z)
v.a=!1}}catch(u){y=H.N(u)
x=H.as(u)
w=H.d(this.a.a.c,"$isX")
v=w.a
t=y
s=this.b
if(v==null?t==null:v===t)s.b=w
else s.b=new P.X(y,x)
s.a=!0}}},
dX:{"^":"b;a,0b"},
ck:{"^":"b;$ti",
gk:function(a){var z,y,x,w
z={}
y=new P.P(0,$.q,[P.w])
z.a=0
x=H.i(this,0)
w=H.c(new P.iB(z,this),{func:1,ret:-1,args:[x]})
H.c(new P.iC(z,y),{func:1,ret:-1})
W.R(this.a,this.b,w,!1,x)
return y}},
iB:{"^":"a;a,b",
$1:function(a){H.l(a,H.i(this.b,0));++this.a.a},
$S:function(){return{func:1,ret:P.k,args:[H.i(this.b,0)]}}},
iC:{"^":"a:1;a,b",
$0:function(){this.b.ah(this.a.a)}},
iz:{"^":"b;"},
iA:{"^":"b;"},
jB:{"^":"b;0a,b,c,$ti"},
aB:{"^":"b;"},
X:{"^":"b;a,b",
i:function(a){return H.f(this.a)},
$isL:1},
jN:{"^":"b;",$iskX:1},
k1:{"^":"a:1;a,b",
$0:function(){var z,y,x
z=this.a
y=z.a
if(y==null){x=new P.cg()
z.a=x
z=x}else z=y
y=this.b
if(y==null)throw H.e(z)
x=H.e(z)
x.stack=y.i(0)
throw x}},
js:{"^":"jN;",
dv:function(a){var z,y,x
H.c(a,{func:1,ret:-1})
try{if(C.i===$.q){a.$0()
return}P.eh(null,null,this,a,-1)}catch(x){z=H.N(x)
y=H.as(x)
P.bL(null,null,this,z,H.d(y,"$isO"))}},
dw:function(a,b,c){var z,y,x
H.c(a,{func:1,ret:-1,args:[c]})
H.l(b,c)
try{if(C.i===$.q){a.$1(b)
return}P.ei(null,null,this,a,b,-1,c)}catch(x){z=H.N(x)
y=H.as(x)
P.bL(null,null,this,z,H.d(y,"$isO"))}},
cS:function(a,b){return new P.ju(this,H.c(a,{func:1,ret:b}),b)},
aP:function(a){return new P.jt(this,H.c(a,{func:1,ret:-1}))},
bq:function(a,b){return new P.jv(this,H.c(a,{func:1,ret:-1,args:[b]}),b)},
bG:function(a,b){H.c(a,{func:1,ret:b})
if($.q===C.i)return a.$0()
return P.eh(null,null,this,a,b)},
aV:function(a,b,c,d){H.c(a,{func:1,ret:c,args:[d]})
H.l(b,d)
if($.q===C.i)return a.$1(b)
return P.ei(null,null,this,a,b,c,d)},
du:function(a,b,c,d,e,f){H.c(a,{func:1,ret:d,args:[e,f]})
H.l(b,e)
H.l(c,f)
if($.q===C.i)return a.$2(b,c)
return P.k2(null,null,this,a,b,c,d,e,f)},
bF:function(a,b,c,d){return H.c(a,{func:1,ret:b,args:[c,d]})}},
ju:{"^":"a;a,b,c",
$0:function(){return this.a.bG(this.b,this.c)},
$S:function(){return{func:1,ret:this.c}}},
jt:{"^":"a:4;a,b",
$0:function(){return this.a.dv(this.b)}},
jv:{"^":"a;a,b,c",
$1:[function(a){var z=this.c
return this.a.dw(this.b,H.l(a,z),z)},null,null,4,0,null,16,"call"],
$S:function(){return{func:1,ret:-1,args:[this.c]}}}}],["","",,P,{"^":"",
hY:function(a,b,c,d,e){return new H.b5(0,0,[d,e])},
dm:function(a,b){return new H.b5(0,0,[a,b])},
aQ:function(a,b,c,d){return new P.jn(0,0,[d])},
h_:function(a,b,c){var z,y
if(P.cA(a)){if(b==="("&&c===")")return"(...)"
return b+"..."+c}z=[]
y=$.$get$aW()
C.b.p(y,a)
try{P.jY(a,z)}finally{if(0>=y.length)return H.A(y,-1)
y.pop()}y=P.dD(b,H.kr(z,"$isp"),", ")+c
return y.charCodeAt(0)==0?y:y},
c6:function(a,b,c){var z,y,x
if(P.cA(a))return b+"..."+c
z=new P.bF(b)
y=$.$get$aW()
C.b.p(y,a)
try{x=z
x.sL(P.dD(x.gL(),a,", "))}finally{if(0>=y.length)return H.A(y,-1)
y.pop()}y=z
y.sL(y.gL()+c)
y=z.gL()
return y.charCodeAt(0)==0?y:y},
cA:function(a){var z,y
for(z=0;y=$.$get$aW(),z<y.length;++z)if(a===y[z])return!0
return!1},
jY:function(a,b){var z,y,x,w,v,u,t,s,r,q
z=a.gB(a)
y=0
x=0
while(!0){if(!(y<80||x<3))break
if(!z.t())return
w=H.f(z.gw())
C.b.p(b,w)
y+=w.length+2;++x}if(!z.t()){if(x<=5)return
if(0>=b.length)return H.A(b,-1)
v=b.pop()
if(0>=b.length)return H.A(b,-1)
u=b.pop()}else{t=z.gw();++x
if(!z.t()){if(x<=4){C.b.p(b,H.f(t))
return}v=H.f(t)
if(0>=b.length)return H.A(b,-1)
u=b.pop()
y+=v.length+2}else{s=z.gw();++x
for(;z.t();t=s,s=r){r=z.gw();++x
if(x>100){while(!0){if(!(y>75&&x>3))break
if(0>=b.length)return H.A(b,-1)
y-=b.pop().length+2;--x}C.b.p(b,"...")
return}}u=H.f(t)
v=H.f(s)
y+=v.length+u.length+4}}if(x>b.length+2){y+=5
q="..."}else q=null
while(!0){if(!(y>80&&b.length>3))break
if(0>=b.length)return H.A(b,-1)
y-=b.pop().length+2
if(q==null){y+=5
q="..."}}if(q!=null)C.b.p(b,q)
C.b.p(b,u)
C.b.p(b,v)},
bB:function(a,b,c){var z=P.hY(null,null,null,b,c)
a.q(0,new P.hZ(z,b,c))
return z},
dn:function(a,b){var z,y,x
z=P.aQ(null,null,null,b)
for(y=a.length,x=0;x<a.length;a.length===y||(0,H.cO)(a),++x)z.p(0,H.l(a[x],b))
return z},
bC:function(a){var z,y,x
z={}
if(P.cA(a))return"{...}"
y=new P.bF("")
try{C.b.p($.$get$aW(),a)
x=y
x.sL(x.gL()+"{")
z.a=!0
J.cR(a,new P.i0(z,y))
z=y
z.sL(z.gL()+"}")}finally{z=$.$get$aW()
if(0>=z.length)return H.A(z,-1)
z.pop()}z=y.gL()
return z.charCodeAt(0)==0?z:z},
jn:{"^":"jh;a,0b,0c,0d,0e,0f,r,$ti",
gB:function(a){var z=new P.e4(this,this.r,this.$ti)
z.c=this.e
return z},
gk:function(a){return this.a},
v:function(a,b){var z,y
if(typeof b==="string"&&b!=="__proto__"){z=this.b
if(z==null)return!1
return H.d(z[b],"$isbJ")!=null}else{y=this.cf(b)
return y}},
cf:function(a){var z=this.d
if(z==null)return!1
return this.aD(this.be(z,a),a)>=0},
p:function(a,b){var z,y
H.l(b,H.i(this,0))
if(typeof b==="string"&&b!=="__proto__"){z=this.b
if(z==null){z=P.cu()
this.b=z}return this.b6(z,b)}else if(typeof b==="number"&&(b&0x3ffffff)===b){y=this.c
if(y==null){y=P.cu()
this.c=y}return this.b6(y,b)}else return this.c7(b)},
c7:function(a){var z,y,x
H.l(a,H.i(this,0))
z=this.d
if(z==null){z=P.cu()
this.d=z}y=this.ba(a)
x=z[y]
if(x==null)z[y]=[this.aH(a)]
else{if(this.aD(x,a)>=0)return!1
x.push(this.aH(a))}return!0},
R:function(a,b){var z
if(b!=="__proto__")return this.ce(this.b,b)
else{z=this.cA(b)
return z}},
cA:function(a){var z,y,x
z=this.d
if(z==null)return!1
y=this.be(z,a)
x=this.aD(y,a)
if(x<0)return!1
this.b9(y.splice(x,1)[0])
return!0},
b6:function(a,b){H.l(b,H.i(this,0))
if(H.d(a[b],"$isbJ")!=null)return!1
a[b]=this.aH(b)
return!0},
ce:function(a,b){var z
if(a==null)return!1
z=H.d(a[b],"$isbJ")
if(z==null)return!1
this.b9(z)
delete a[b]
return!0},
bh:function(){this.r=this.r+1&67108863},
aH:function(a){var z,y
z=new P.bJ(H.l(a,H.i(this,0)))
if(this.e==null){this.f=z
this.e=z}else{y=this.f
z.c=y
y.b=z
this.f=z}++this.a
this.bh()
return z},
b9:function(a){var z,y
z=a.c
y=a.b
if(z==null)this.e=y
else z.b=y
if(y==null)this.f=z
else y.c=z;--this.a
this.bh()},
ba:function(a){return J.bj(a)&0x3ffffff},
be:function(a,b){return a[this.ba(b)]},
aD:function(a,b){var z,y
if(a==null)return-1
z=a.length
for(y=0;y<z;++y)if(J.bg(a[y].a,b))return y
return-1},
m:{
cu:function(){var z=Object.create(null)
z["<non-identifier-key>"]=z
delete z["<non-identifier-key>"]
return z}}},
bJ:{"^":"b;a,0b,0c"},
e4:{"^":"b;a,b,0c,0d,$ti",
sb8:function(a){this.d=H.l(a,H.i(this,0))},
gw:function(){return this.d},
t:function(){var z=this.a
if(this.b!==z.r)throw H.e(P.a4(z))
else{z=this.c
if(z==null){this.sb8(null)
return!1}else{this.sb8(H.l(z.a,H.i(this,0)))
this.c=this.c.b
return!0}}},
$isah:1,
m:{
jo:function(a,b,c){var z=new P.e4(a,b,[c])
z.c=a.e
return z}}},
jh:{"^":"dz;"},
hZ:{"^":"a:13;a,b,c",
$2:function(a,b){this.a.D(0,H.l(a,this.b),H.l(b,this.c))}},
cd:{"^":"jp;",$isp:1,$ist:1},
I:{"^":"b;$ti",
gB:function(a){return new H.dp(a,this.gk(a),0,[H.a7(this,a,"I",0)])},
C:function(a,b){return this.l(a,b)},
q:function(a,b){var z,y
H.c(b,{func:1,ret:-1,args:[H.a7(this,a,"I",0)]})
z=this.gk(a)
if(typeof z!=="number")return H.j(z)
y=0
for(;y<z;++y){b.$1(this.l(a,y))
if(z!==this.gk(a))throw H.e(P.a4(a))}},
bA:function(a,b,c){var z=H.a7(this,a,"I",0)
return new H.bD(a,H.c(b,{func:1,ret:c,args:[z]}),[z,c])},
dB:function(a,b){var z,y,x
z=H.y([],[H.a7(this,a,"I",0)])
C.b.sk(z,this.gk(a))
y=0
while(!0){x=this.gk(a)
if(typeof x!=="number")return H.j(x)
if(!(y<x))break
C.b.D(z,y,this.l(a,y));++y}return z},
dA:function(a){return this.dB(a,!0)},
i:function(a){return P.c6(a,"[","]")}},
ce:{"^":"ab;"},
i0:{"^":"a:13;a,b",
$2:function(a,b){var z,y
z=this.a
if(!z.a)this.b.a+=", "
z.a=!1
z=this.b
y=z.a+=H.f(a)
z.a=y+": "
z.a+=H.f(b)}},
ab:{"^":"b;$ti",
q:function(a,b){var z,y
H.c(b,{func:1,ret:-1,args:[H.a7(this,a,"ab",0),H.a7(this,a,"ab",1)]})
for(z=J.at(this.gI(a));z.t();){y=z.gw()
b.$2(y,this.l(a,y))}},
n:function(a,b,c){var z
H.l(b,H.a7(this,a,"ab",0))
H.c(c,{func:1,ret:H.a7(this,a,"ab",1)})
if(this.G(a,b))return this.l(a,b)
z=c.$0()
this.D(a,b,z)
return z},
G:function(a,b){return J.eD(this.gI(a),b)},
gk:function(a){return J.a1(this.gI(a))},
i:function(a){return P.bC(a)},
$isK:1},
jK:{"^":"b;$ti",
n:function(a,b,c){H.l(b,H.i(this,0))
H.c(c,{func:1,ret:H.i(this,1)})
throw H.e(P.Q("Cannot modify unmodifiable map"))}},
i1:{"^":"b;$ti",
n:function(a,b,c){return this.a.n(0,H.l(b,H.i(this,0)),H.c(c,{func:1,ret:H.i(this,1)}))},
q:function(a,b){this.a.q(0,H.c(b,{func:1,ret:-1,args:[H.i(this,0),H.i(this,1)]}))},
gk:function(a){var z=this.a
return z.gk(z)},
i:function(a){return P.bC(this.a)},
$isK:1},
iM:{"^":"jL;$ti"},
ci:{"^":"b;$ti",
M:function(a,b){var z
for(z=J.at(H.V(b,"$isp",[H.aY(this,"ci",0)],"$asp"));z.t();)this.p(0,z.gw())},
i:function(a){return P.c6(this,"{","}")},
aS:function(a,b){var z,y
z=this.gB(this)
if(!z.t())return""
if(b===""){y=""
do y+=H.f(z.d)
while(z.t())}else{y=H.f(z.d)
for(;z.t();)y=y+b+H.f(z.d)}return y.charCodeAt(0)==0?y:y},
C:function(a,b){var z,y,x
if(typeof b!=="number"||Math.floor(b)!==b)throw H.e(P.cV("index"))
if(b<0)H.S(P.az(b,0,null,"index",null))
for(z=this.gB(this),y=0;z.t();){x=z.d
if(b===y)return x;++y}throw H.e(P.ax(b,this,"index",null,y))},
$isp:1,
$isac:1},
dz:{"^":"ci;"},
jp:{"^":"b+I;"},
jL:{"^":"i1+jK;$ti"}}],["","",,P,{"^":"",
k_:function(a,b){var z,y,x,w
if(typeof a!=="string")throw H.e(H.aH(a))
z=null
try{z=JSON.parse(a)}catch(x){y=H.N(x)
w=P.c3(String(y),null,null)
throw H.e(w)}w=P.bK(z)
return w},
bK:function(a){var z
if(a==null)return
if(typeof a!="object")return a
if(Object.getPrototypeOf(a)!==Array.prototype)return new P.jl(a,Object.create(null))
for(z=0;z<a.length;++z)a[z]=P.bK(a[z])
return a},
jl:{"^":"ce;a,b,0c",
l:function(a,b){var z,y
z=this.b
if(z==null)return this.c.l(0,b)
else if(typeof b!=="string")return
else{y=z[b]
return typeof y=="undefined"?this.cz(b):y}},
gk:function(a){var z
if(this.b==null){z=this.c
z=z.gk(z)}else z=this.a7().length
return z},
gI:function(a){var z
if(this.b==null){z=this.c
return z.gI(z)}return new P.jm(this)},
D:function(a,b,c){var z,y
if(this.b==null)this.c.D(0,b,c)
else if(this.G(0,b)){z=this.b
z[b]=c
y=this.a
if(y==null?z!=null:y!==z)y[b]=null}else this.cO().D(0,b,c)},
G:function(a,b){if(this.b==null)return this.c.G(0,b)
return Object.prototype.hasOwnProperty.call(this.a,b)},
n:function(a,b,c){var z
H.c(c,{func:1})
if(this.G(0,b))return this.l(0,b)
z=c.$0()
this.D(0,b,z)
return z},
q:function(a,b){var z,y,x,w
H.c(b,{func:1,ret:-1,args:[P.h,,]})
if(this.b==null)return this.c.q(0,b)
z=this.a7()
for(y=0;y<z.length;++y){x=z[y]
w=this.b[x]
if(typeof w=="undefined"){w=P.bK(this.a[x])
this.b[x]=w}b.$2(x,w)
if(z!==this.c)throw H.e(P.a4(this))}},
a7:function(){var z=H.aZ(this.c)
if(z==null){z=H.y(Object.keys(this.a),[P.h])
this.c=z}return z},
cO:function(){var z,y,x,w,v
if(this.b==null)return this.c
z=P.dm(P.h,null)
y=this.a7()
for(x=0;w=y.length,x<w;++x){v=y[x]
z.D(0,v,this.l(0,v))}if(w===0)C.b.p(y,null)
else C.b.sk(y,0)
this.b=null
this.a=null
this.c=z
return z},
cz:function(a){var z
if(!Object.prototype.hasOwnProperty.call(this.a,a))return
z=P.bK(this.a[a])
return this.b[a]=z},
$asab:function(){return[P.h,null]},
$asK:function(){return[P.h,null]}},
jm:{"^":"aj;a",
gk:function(a){var z=this.a
return z.gk(z)},
C:function(a,b){var z=this.a
return z.b==null?z.gI(z).C(0,b):C.b.l(z.a7(),b)},
gB:function(a){var z=this.a
if(z.b==null){z=z.gI(z)
z=z.gB(z)}else{z=z.a7()
z=new J.bm(z,z.length,0,[H.i(z,0)])}return z},
v:function(a,b){return this.a.G(0,b)},
$asaj:function(){return[P.h]},
$asp:function(){return[P.h]}},
d0:{"^":"b;$ti"},
d1:{"^":"iA;$ti"},
ha:{"^":"d0;a,b",
d0:function(a,b,c){var z=P.k_(b,this.gd1().a)
return z},
d_:function(a,b){return this.d0(a,b,null)},
gd1:function(){return C.R},
$asd0:function(){return[P.b,P.h]}},
hb:{"^":"d1;a",
$asd1:function(){return[P.h,P.b]}}}],["","",,P,{"^":"",
bf:function(a,b,c){var z=H.ir(a,c)
if(z!=null)return z
throw H.e(P.c3(a,null,null))},
fJ:function(a){if(a instanceof H.a)return a.i(0)
return"Instance of '"+H.aS(a)+"'"},
ay:function(a,b,c){var z,y,x
z=[c]
y=H.y([],z)
for(x=J.at(a);x.t();)C.b.p(y,H.l(x.gw(),c))
if(b)return y
return H.V(J.bv(y),"$ist",z,"$ast")},
dx:function(a,b,c){return new H.h7(a,H.h8(a,!1,!0,!1))},
aw:function(a){if(typeof a==="number"||typeof a==="boolean"||null==a)return J.B(a)
if(typeof a==="string")return JSON.stringify(a)
return P.fJ(a)},
i7:{"^":"a:50;a,b",
$2:function(a,b){var z,y,x
H.d(a,"$isaA")
z=this.b
y=this.a
z.a+=y.a
x=z.a+=H.f(a.a)
z.a=x+": "
z.a+=H.f(P.aw(b))
y.a=", "}},
z:{"^":"b;"},
"+bool":0,
c_:{"^":"b;a,b",
T:function(a,b){if(b==null)return!1
if(!(b instanceof P.c_))return!1
return this.a===b.a&&!0},
gE:function(a){var z=this.a
return(z^C.f.bl(z,30))&1073741823},
i:function(a){var z,y,x,w,v,u,t,s
z=P.fg(H.iq(this))
y=P.b0(H.io(this))
x=P.b0(H.ij(this))
w=P.b0(H.ik(this))
v=P.b0(H.im(this))
u=P.b0(H.ip(this))
t=P.fh(H.il(this))
s=z+"-"+y+"-"+x+" "+w+":"+v+":"+u+"."+t
return s},
m:{
fg:function(a){var z,y
z=Math.abs(a)
y=a<0?"-":""
if(z>=1000)return""+a
if(z>=100)return y+"0"+z
if(z>=10)return y+"00"+z
return y+"000"+z},
fh:function(a){if(a>=100)return""+a
if(a>=10)return"0"+a
return"00"+a},
b0:function(a){if(a>=10)return""+a
return"0"+a}}},
aI:{"^":"cM;"},
"+double":0,
b2:{"^":"b;a",
Z:function(a,b){return C.f.Z(this.a,H.d(b,"$isb2").a)},
T:function(a,b){if(b==null)return!1
if(!(b instanceof P.b2))return!1
return this.a===b.a},
gE:function(a){return this.a&0x1FFFFFFF},
i:function(a){var z,y,x,w,v
z=new P.fG()
y=this.a
if(y<0)return"-"+new P.b2(0-y).i(0)
x=z.$1(C.f.ab(y,6e7)%60)
w=z.$1(C.f.ab(y,1e6)%60)
v=new P.fF().$1(y%1e6)
return""+C.f.ab(y,36e8)+":"+H.f(x)+":"+H.f(w)+"."+H.f(v)},
m:{
av:function(a,b,c,d,e,f){return new P.b2(864e8*a+36e8*b+6e7*e+1e6*f+1000*d+c)}}},
fF:{"^":"a:14;",
$1:function(a){if(a>=1e5)return""+a
if(a>=1e4)return"0"+a
if(a>=1000)return"00"+a
if(a>=100)return"000"+a
if(a>=10)return"0000"+a
return"00000"+a}},
fG:{"^":"a:14;",
$1:function(a){if(a>=10)return""+a
return"0"+a}},
L:{"^":"b;"},
cg:{"^":"L;",
i:function(a){return"Throw of null."}},
a8:{"^":"L;a,b,c,d",
gaC:function(){return"Invalid argument"+(!this.a?"(s)":"")},
gaB:function(){return""},
i:function(a){var z,y,x,w,v,u
z=this.c
y=z!=null?" ("+z+")":""
z=this.d
x=z==null?"":": "+H.f(z)
w=this.gaC()+y+x
if(!this.a)return w
v=this.gaB()
u=P.aw(this.b)
return w+v+": "+H.f(u)},
m:{
bU:function(a){return new P.a8(!1,null,null,a)},
bl:function(a,b,c){return new P.a8(!0,a,b,c)},
cV:function(a){return new P.a8(!1,null,a,"Must not be null")}}},
dv:{"^":"a8;e,f,a,b,c,d",
gaC:function(){return"RangeError"},
gaB:function(){var z,y,x
z=this.e
if(z==null){z=this.f
y=z!=null?": Not less than or equal to "+H.f(z):""}else{x=this.f
if(x==null)y=": Not greater than or equal to "+H.f(z)
else if(x>z)y=": Not in range "+H.f(z)+".."+H.f(x)+", inclusive"
else y=x<z?": Valid value range is empty":": Only valid value is "+H.f(z)}return y},
m:{
b9:function(a,b,c){return new P.dv(null,null,!0,a,b,"Value not in range")},
az:function(a,b,c,d,e){return new P.dv(b,c,!0,a,d,"Invalid value")}}},
fZ:{"^":"a8;e,k:f>,a,b,c,d",
gaC:function(){return"RangeError"},
gaB:function(){if(J.ez(this.b,0))return": index must not be negative"
var z=this.f
if(z===0)return": no indices are valid"
return": index should be less than "+H.f(z)},
m:{
ax:function(a,b,c,d,e){var z=H.M(e!=null?e:J.a1(b))
return new P.fZ(b,z,!0,a,c,"Index out of range")}}},
i6:{"^":"L;a,b,c,d,e",
i:function(a){var z,y,x,w,v,u,t,s,r,q
z={}
y=new P.bF("")
z.a=""
for(x=this.c,w=x.length,v=0,u="",t="";v<w;++v,t=", "){s=x[v]
y.a=u+t
u=y.a+=H.f(P.aw(s))
z.a=", "}this.d.q(0,new P.i7(z,y))
r=P.aw(this.a)
q=y.i(0)
x="NoSuchMethodError: method not found: '"+H.f(this.b.a)+"'\nReceiver: "+H.f(r)+"\nArguments: ["+q+"]"
return x},
m:{
dq:function(a,b,c,d,e){return new P.i6(a,b,c,d,e)}}},
iN:{"^":"L;a",
i:function(a){return"Unsupported operation: "+this.a},
m:{
Q:function(a){return new P.iN(a)}}},
iK:{"^":"L;a",
i:function(a){var z=this.a
return z!=null?"UnimplementedError: "+z:"UnimplementedError"},
m:{
dU:function(a){return new P.iK(a)}}},
cj:{"^":"L;a",
i:function(a){return"Bad state: "+this.a},
m:{
aT:function(a){return new P.cj(a)}}},
f7:{"^":"L;a",
i:function(a){var z=this.a
if(z==null)return"Concurrent modification during iteration."
return"Concurrent modification during iteration: "+H.f(P.aw(z))+"."},
m:{
a4:function(a){return new P.f7(a)}}},
dB:{"^":"b;",
i:function(a){return"Stack Overflow"},
$isL:1},
ff:{"^":"L;a",
i:function(a){var z=this.a
return z==null?"Reading static variable during its initialization":"Reading static variable '"+z+"' during its initialization"}},
j4:{"^":"b;a",
i:function(a){return"Exception: "+this.a}},
fN:{"^":"b;a,b,c",
i:function(a){var z,y,x
z=this.a
y=z!=null&&""!==z?"FormatException: "+H.f(z):"FormatException"
x=this.b
if(typeof x!=="string")return y
if(x.length>78)x=C.k.b2(x,0,75)+"..."
return y+"\n"+x},
m:{
c3:function(a,b,c){return new P.fN(a,b,c)}}},
af:{"^":"b;"},
w:{"^":"cM;"},
"+int":0,
p:{"^":"b;$ti",
aZ:["bW",function(a,b){var z=H.aY(this,"p",0)
return new H.co(this,H.c(b,{func:1,ret:P.z,args:[z]}),[z])}],
gk:function(a){var z,y
z=this.gB(this)
for(y=0;z.t();)++y
return y},
ga3:function(a){var z,y
z=this.gB(this)
if(!z.t())throw H.e(H.c7())
y=z.gw()
if(z.t())throw H.e(H.h0())
return y},
C:function(a,b){var z,y,x
if(typeof b!=="number"||Math.floor(b)!==b)throw H.e(P.cV("index"))
if(b<0)H.S(P.az(b,0,null,"index",null))
for(z=this.gB(this),y=0;z.t();){x=z.gw()
if(b===y)return x;++y}throw H.e(P.ax(b,this,"index",null,y))},
i:function(a){return P.h_(this,"(",")")}},
ah:{"^":"b;$ti"},
t:{"^":"b;$ti",$isp:1},
"+List":0,
K:{"^":"b;$ti"},
k:{"^":"b;",
gE:function(a){return P.b.prototype.gE.call(this,this)},
i:function(a){return"null"}},
"+Null":0,
cM:{"^":"b;"},
"+num":0,
b:{"^":";",
T:function(a,b){return this===b},
gE:function(a){return H.aR(this)},
i:["bZ",function(a){return"Instance of '"+H.aS(this)+"'"}],
aT:function(a,b){H.d(b,"$isc5")
throw H.e(P.dq(this,b.gbB(),b.gbE(),b.gbC(),null))},
toString:function(){return this.i(this)}},
ac:{"^":"c0;$ti"},
O:{"^":"b;"},
h:{"^":"b;",$isdt:1},
"+String":0,
bF:{"^":"b;L:a<",
sL:function(a){this.a=H.m(a)},
gk:function(a){return this.a.length},
i:function(a){var z=this.a
return z.charCodeAt(0)==0?z:z},
m:{
dD:function(a,b,c){var z=J.at(b)
if(!z.t())return a
if(c.length===0){do a+=H.f(z.gw())
while(z.t())}else{a+=H.f(z.gw())
for(;z.t();)a=a+c+H.f(z.gw())}return a}}},
aA:{"^":"b;"}}],["","",,W,{"^":"",
kw:function(a,b){var z,y
z=new P.P(0,$.q,[b])
y=new P.dY(z,[b])
a.then(H.ap(new W.kx(y,b),1),H.ap(new W.ky(y),1))
return z},
fH:function(a,b,c){var z,y
z=document.body
y=(z&&C.n).O(z,a,b,c)
y.toString
z=W.n
z=new H.co(new W.Y(y),H.c(new W.fI(),{func:1,ret:P.z,args:[z]}),[z])
return H.d(z.ga3(z),"$iso")},
aM:function(a){var z,y,x,w
z="element tag unavailable"
try{y=J.r(a)
x=y.gbH(a)
if(typeof x==="string")z=y.gbH(a)}catch(w){H.N(w)}return z},
fU:function(a,b,c){return W.fW(a,null,null,b,null,null,null,c).N(new W.fV(),P.h)},
fW:function(a,b,c,d,e,f,g,h){var z,y,x,w,v
z=W.aP
y=new P.P(0,$.q,[z])
x=new P.dY(y,[z])
w=new XMLHttpRequest()
C.H.dq(w,"GET",a,!0)
z=W.b8
v={func:1,ret:-1,args:[z]}
W.R(w,"load",H.c(new W.fX(w,x),v),!1,z)
W.R(w,"error",H.c(x.gbv(),v),!1,z)
w.send()
return y},
c4:function(a,b,c){var z=document.createElement("img")
if(b!=null)z.src=b
return z},
k8:function(a,b){var z
H.c(a,{func:1,ret:-1,args:[b]})
z=$.q
if(z===C.i)return a
return z.bq(a,b)},
kx:{"^":"a:7;a,b",
$1:[function(a){return this.a.W(0,H.ad(a,{futureOr:1,type:this.b}))},null,null,4,0,null,17,"call"]},
ky:{"^":"a:7;a",
$1:[function(a){return this.a.bw(a)},null,null,4,0,null,18,"call"]},
J:{"^":"o;",$isJ:1,"%":"HTMLAudioElement|HTMLBRElement|HTMLCanvasElement|HTMLContentElement|HTMLDListElement|HTMLDataElement|HTMLDataListElement|HTMLDetailsElement|HTMLDialogElement|HTMLDirectoryElement|HTMLEmbedElement|HTMLFieldSetElement|HTMLFontElement|HTMLFrameElement|HTMLFrameSetElement|HTMLHRElement|HTMLHtmlElement|HTMLIFrameElement|HTMLInputElement|HTMLLIElement|HTMLLabelElement|HTMLLegendElement|HTMLLinkElement|HTMLMapElement|HTMLMarqueeElement|HTMLMediaElement|HTMLMenuElement|HTMLMetaElement|HTMLMeterElement|HTMLModElement|HTMLOListElement|HTMLObjectElement|HTMLOptGroupElement|HTMLOptionElement|HTMLOutputElement|HTMLParamElement|HTMLPictureElement|HTMLPreElement|HTMLQuoteElement|HTMLScriptElement|HTMLShadowElement|HTMLSlotElement|HTMLSourceElement|HTMLStyleElement|HTMLTableCaptionElement|HTMLTableCellElement|HTMLTableColElement|HTMLTableDataCellElement|HTMLTableHeaderCellElement|HTMLTextAreaElement|HTMLTimeElement|HTMLTitleElement|HTMLTrackElement|HTMLUListElement|HTMLUnknownElement|HTMLVideoElement;HTMLElement"},
eN:{"^":"J;",
i:function(a){return String(a)},
$iseN:1,
"%":"HTMLAnchorElement"},
kD:{"^":"J;",
i:function(a){return String(a)},
"%":"HTMLAreaElement"},
cW:{"^":"J;",$iscW:1,"%":"HTMLBaseElement"},
cX:{"^":"x;",$iscX:1,"%":"Blob|File"},
bn:{"^":"J;",$isbn:1,"%":"HTMLBodyElement"},
eZ:{"^":"J;","%":"HTMLButtonElement"},
kE:{"^":"n;0k:length=","%":"CDATASection|CharacterData|Comment|ProcessingInstruction|Text"},
fd:{"^":"iX;0k:length=",
cb:function(a,b){var z,y
z=$.$get$d4()
y=z[b]
if(typeof y==="string")return y
y=this.cK(a,b)
z[b]=y
return y},
cK:function(a,b){var z
if(b.replace(/^-ms-/,"ms-").replace(/-([\da-z])/ig,function(c,d){return d.toUpperCase()}) in a)return b
z=P.fi()+b
if(z in a)return z
return b},
cG:function(a,b,c,d){a.setProperty(b,c,d)},
"%":"CSS2Properties|CSSStyleDeclaration|MSStyleCSSProperties"},
fe:{"^":"b;"},
b1:{"^":"U;",$isb1:1,"%":"DeviceOrientationEvent"},
br:{"^":"J;",$isbr:1,"%":"HTMLDivElement"},
fj:{"^":"n;",
cP:function(a,b){return a.adoptNode(b)},
J:function(a,b){return a.querySelector(b)},
"%":"XMLDocument;Document"},
kF:{"^":"x;",
i:function(a){return String(a)},
"%":"DOMException"},
fk:{"^":"x;",
cZ:function(a,b){return a.createHTMLDocument(b)},
"%":"DOMImplementation"},
kG:{"^":"x;0k:length=","%":"DOMTokenList"},
cr:{"^":"cd;aA:a<,b",
gk:function(a){return this.b.length},
l:function(a,b){return H.d(J.cP(this.b,b),"$iso")},
gB:function(a){var z=this.dA(this)
return new J.bm(z,z.length,0,[H.i(z,0)])},
$asI:function(){return[W.o]},
$asp:function(){return[W.o]},
$ast:function(){return[W.o]}},
o:{"^":"n;0bH:tagName=",
gcR:function(a){return new W.j_(a)},
gbt:function(a){return new W.cr(a,a.children)},
gac:function(a){return new W.j0(a)},
i:function(a){return a.localName},
bx:function(a,b,c){var z
if(!!a.insertAdjacentElement)this.cu(a,b,c)
else switch(b.toLowerCase()){case"beforebegin":J.cS(a.parentNode,c,a)
break
case"afterbegin":z=a.childNodes
this.by(a,c,z.length>0?z[0]:null)
break
case"beforeend":this.h(a,c)
break
case"afterend":J.cS(a.parentNode,c,a.nextSibling)
break
default:H.S(P.bU("Invalid position "+b))}return c},
cu:function(a,b,c){return a.insertAdjacentElement(b,c)},
O:["ax",function(a,b,c,d){var z,y,x,w
if(c==null){z=$.dd
if(z==null){z=H.y([],[W.a5])
y=new W.dr(z)
C.b.p(z,W.e2(null))
C.b.p(z,W.ea())
$.dd=y
d=y}else d=z
z=$.dc
if(z==null){z=new W.ec(d)
$.dc=z
c=z}else{z.a=d
c=z}}if($.a9==null){z=document
y=z.implementation
y=(y&&C.E).cZ(y,"")
$.a9=y
$.c1=y.createRange()
y=$.a9
y.toString
y=y.createElement("base")
H.d(y,"$iscW")
y.href=z.baseURI
z=$.a9.head;(z&&C.G).h(z,y)}z=$.a9
if(z.body==null){z.toString
y=z.createElement("body")
z.body=H.d(y,"$isbn")}z=$.a9
if(!!this.$isbn)x=z.body
else{y=a.tagName
z.toString
x=z.createElement(y)
z=$.a9.body;(z&&C.n).h(z,x)}if("createContextualFragment" in window.Range.prototype&&!C.b.v(C.T,a.tagName)){z=$.c1;(z&&C.C).bQ(z,x)
z=$.c1
w=(z&&C.C).cX(z,b)}else{x.innerHTML=b
w=$.a9.createDocumentFragment()
for(z=J.r(w);y=x.firstChild,y!=null;)z.h(w,y)}z=$.a9.body
if(x==null?z!=null:x!==z)J.bS(x)
c.b0(w)
C.h.cP(document,w)
return w},function(a,b,c){return this.O(a,b,c,null)},"cY",null,null,"gdF",5,5,null],
av:function(a,b,c,d){a.textContent=null
this.h(a,this.O(a,b,c,d))},
a5:function(a,b){return this.av(a,b,null,null)},
a2:function(a,b){return a.getAttribute(b)},
bf:function(a,b){return a.hasAttribute(b)},
cB:function(a,b){return a.removeAttribute(b)},
j:function(a,b,c){return a.setAttribute(b,c)},
gbD:function(a){return new W.e0(a,"click",!1,[W.T])},
$iso:1,
"%":";Element"},
fI:{"^":"a:12;",
$1:function(a){return!!J.u(H.d(a,"$isn")).$iso}},
U:{"^":"x;",$isU:1,"%":"AbortPaymentEvent|AnimationEvent|AnimationPlaybackEvent|ApplicationCacheErrorEvent|AudioProcessingEvent|BackgroundFetchClickEvent|BackgroundFetchEvent|BackgroundFetchFailEvent|BackgroundFetchedEvent|BeforeInstallPromptEvent|BeforeUnloadEvent|BlobEvent|CanMakePaymentEvent|ClipboardEvent|CloseEvent|CustomEvent|DeviceMotionEvent|ErrorEvent|ExtendableEvent|ExtendableMessageEvent|FetchEvent|FontFaceSetLoadEvent|ForeignFetchEvent|GamepadEvent|HashChangeEvent|IDBVersionChangeEvent|InstallEvent|MIDIConnectionEvent|MIDIMessageEvent|MediaEncryptedEvent|MediaKeyMessageEvent|MediaQueryListEvent|MediaStreamEvent|MediaStreamTrackEvent|MessageEvent|MojoInterfaceRequestEvent|MutationEvent|NotificationEvent|OfflineAudioCompletionEvent|PageTransitionEvent|PaymentRequestEvent|PaymentRequestUpdateEvent|PopStateEvent|PresentationConnectionAvailableEvent|PresentationConnectionCloseEvent|PromiseRejectionEvent|PushEvent|RTCDTMFToneChangeEvent|RTCDataChannelEvent|RTCPeerConnectionIceEvent|RTCTrackEvent|SecurityPolicyViolationEvent|SensorErrorEvent|SpeechRecognitionError|SpeechRecognitionEvent|SpeechSynthesisEvent|StorageEvent|SyncEvent|TrackEvent|TransitionEvent|USBConnectionEvent|VRDeviceEvent|VRDisplayEvent|VRSessionEvent|WebGLContextEvent|WebKitTransitionEvent;Event|InputEvent"},
aN:{"^":"x;",
c8:function(a,b,c,d){return a.addEventListener(b,H.ap(H.c(c,{func:1,args:[W.U]}),1),!1)},
$isaN:1,
"%":"ScreenOrientation;EventTarget"},
kH:{"^":"J;0k:length=","%":"HTMLFormElement"},
fP:{"^":"J;","%":"HTMLHeadElement"},
fQ:{"^":"J;","%":"HTMLHeadingElement"},
fR:{"^":"jj;",
gk:function(a){return a.length},
l:function(a,b){if(b>>>0!==b||b>=a.length)throw H.e(P.ax(b,a,null,null,null))
return a[b]},
C:function(a,b){return this.l(a,b)},
$isaa:1,
$asaa:function(){return[W.n]},
$asI:function(){return[W.n]},
$isp:1,
$asp:function(){return[W.n]},
$ist:1,
$ast:function(){return[W.n]},
$isfR:1,
$asag:function(){return[W.n]},
"%":"HTMLCollection|HTMLFormControlsCollection|HTMLOptionsCollection"},
fS:{"^":"fj;","%":"HTMLDocument"},
aP:{"^":"fT;",
dG:function(a,b,c,d,e,f){return a.open(b,c)},
dq:function(a,b,c,d){return a.open(b,c,d)},
$isaP:1,
"%":"XMLHttpRequest"},
fV:{"^":"a:19;",
$1:function(a){return H.d(a,"$isaP").responseText}},
fX:{"^":"a:20;a,b",
$1:function(a){var z,y,x,w,v
H.d(a,"$isb8")
z=this.a
y=z.status
if(typeof y!=="number")return y.bO()
x=y>=200&&y<300
w=y>307&&y<400
y=x||y===0||y===304||w
v=this.b
if(y)v.W(0,z)
else v.bw(a)}},
fT:{"^":"aN;","%":";XMLHttpRequestEventTarget"},
df:{"^":"x;",$isdf:1,"%":"ImageData"},
fY:{"^":"J;","%":"HTMLImageElement"},
b6:{"^":"dT;",$isb6:1,"%":"KeyboardEvent"},
i_:{"^":"x;",
i:function(a){return String(a)},
$isi_:1,
"%":"Location"},
T:{"^":"dT;",$isT:1,"%":"DragEvent|MouseEvent|PointerEvent|WheelEvent"},
Y:{"^":"cd;a",
ga3:function(a){var z,y
z=this.a
y=z.childNodes.length
if(y===0)throw H.e(P.aT("No elements"))
if(y>1)throw H.e(P.aT("More than one element"))
return z.firstChild},
M:function(a,b){var z,y,x,w,v
H.V(b,"$isp",[W.n],"$asp")
z=b.a
y=this.a
if(z!==y)for(x=z.childNodes.length,w=J.r(y),v=0;v<x;++v)w.h(y,z.firstChild)
return},
gB:function(a){var z=this.a.childNodes
return new W.de(z,z.length,-1,[H.a7(C.A,z,"ag",0)])},
gk:function(a){return this.a.childNodes.length},
l:function(a,b){return C.A.l(this.a.childNodes,b)},
$asI:function(){return[W.n]},
$asp:function(){return[W.n]},
$ast:function(){return[W.n]}},
n:{"^":"aN;0dr:previousSibling=",
dt:function(a){var z=a.parentNode
if(z!=null)J.bh(z,a)},
i:function(a){var z=a.nodeValue
return z==null?this.bV(a):z},
h:function(a,b){return a.appendChild(b)},
by:function(a,b,c){return a.insertBefore(b,c)},
cC:function(a,b){return a.removeChild(b)},
$isn:1,
"%":"DocumentFragment|DocumentType|ShadowRoot;Node"},
i8:{"^":"jr;",
gk:function(a){return a.length},
l:function(a,b){if(b>>>0!==b||b>=a.length)throw H.e(P.ax(b,a,null,null,null))
return a[b]},
C:function(a,b){return this.l(a,b)},
$isaa:1,
$asaa:function(){return[W.n]},
$asI:function(){return[W.n]},
$isp:1,
$asp:function(){return[W.n]},
$ist:1,
$ast:function(){return[W.n]},
$asag:function(){return[W.n]},
"%":"NodeList|RadioNodeList"},
ic:{"^":"J;","%":"HTMLParagraphElement"},
ch:{"^":"J;",$isch:1,"%":"HTMLProgressElement"},
b8:{"^":"U;",$isb8:1,"%":"ProgressEvent|ResourceProgressEvent"},
is:{"^":"x;",
cX:function(a,b){return a.createContextualFragment(b)},
bQ:function(a,b){return a.selectNodeContents(b)},
"%":"Range"},
kS:{"^":"J;0k:length=","%":"HTMLSelectElement"},
iw:{"^":"J;","%":"HTMLSpanElement"},
dC:{"^":"jA;",
G:function(a,b){return this.F(a,b)!=null},
l:function(a,b){return this.F(a,H.m(b))},
D:function(a,b,c){this.aa(a,b,H.m(c))},
n:function(a,b,c){H.c(c,{func:1,ret:P.h})
if(this.F(a,b)==null)this.aa(a,b,H.m(c.$0()))
return this.F(a,b)},
q:function(a,b){var z,y
H.c(b,{func:1,ret:-1,args:[P.h,P.h]})
for(z=0;!0;++z){y=this.cv(a,z)
if(y==null)return
b.$2(y,this.F(a,y))}},
gI:function(a){var z=H.y([],[P.h])
this.q(a,new W.iy(z))
return z},
gk:function(a){return a.length},
F:function(a,b){return a.getItem(b)},
cv:function(a,b){return a.key(b)},
aa:function(a,b,c){return a.setItem(b,c)},
$asab:function(){return[P.h,P.h]},
$isK:1,
$asK:function(){return[P.h,P.h]},
$isdC:1,
"%":"Storage"},
iy:{"^":"a:21;a",
$2:function(a,b){return C.b.p(this.a,a)}},
iF:{"^":"J;",
O:function(a,b,c,d){var z,y
if("createContextualFragment" in window.Range.prototype)return this.ax(a,b,c,d)
z=W.fH("<table>"+b+"</table>",c,d)
y=document.createDocumentFragment()
y.toString
z.toString
new W.Y(y).M(0,new W.Y(z))
return y},
"%":"HTMLTableElement"},
kU:{"^":"J;",
O:function(a,b,c,d){var z,y,x,w
if("createContextualFragment" in window.Range.prototype)return this.ax(a,b,c,d)
z=document
y=z.createDocumentFragment()
z=C.D.O(z.createElement("table"),b,c,d)
z.toString
z=new W.Y(z)
x=z.ga3(z)
x.toString
z=new W.Y(x)
w=z.ga3(z)
y.toString
w.toString
new W.Y(y).M(0,new W.Y(w))
return y},
"%":"HTMLTableRowElement"},
kV:{"^":"J;",
O:function(a,b,c,d){var z,y,x
if("createContextualFragment" in window.Range.prototype)return this.ax(a,b,c,d)
z=document
y=z.createDocumentFragment()
z=C.D.O(z.createElement("table"),b,c,d)
z.toString
z=new W.Y(z)
x=z.ga3(z)
y.toString
x.toString
new W.Y(y).M(0,new W.Y(x))
return y},
"%":"HTMLTableSectionElement"},
dF:{"^":"J;",
av:function(a,b,c,d){var z
a.textContent=null
z=this.O(a,b,c,d)
J.eC(a.content,z)},
a5:function(a,b){return this.av(a,b,null,null)},
$isdF:1,
"%":"HTMLTemplateElement"},
dT:{"^":"U;","%":"CompositionEvent|FocusEvent|TextEvent|TouchEvent;UIEvent"},
cp:{"^":"aN;",
dn:function(a,b,c,d){var z=W.iZ(a.open(b,c))
return z},
dm:function(a,b,c){return this.dn(a,b,c,null)},
$iscp:1,
"%":"DOMWindow|Window"},
dV:{"^":"aN;",$isdV:1,"%":"DedicatedWorkerGlobalScope|ServiceWorkerGlobalScope|SharedWorkerGlobalScope|WorkerGlobalScope"},
dZ:{"^":"n;",$isdZ:1,"%":"Attr"},
l2:{"^":"jP;",
gk:function(a){return a.length},
l:function(a,b){if(b>>>0!==b||b>=a.length)throw H.e(P.ax(b,a,null,null,null))
return a[b]},
C:function(a,b){return this.l(a,b)},
$isaa:1,
$asaa:function(){return[W.n]},
$asI:function(){return[W.n]},
$isp:1,
$asp:function(){return[W.n]},
$ist:1,
$ast:function(){return[W.n]},
$asag:function(){return[W.n]},
"%":"MozNamedAttrMap|NamedNodeMap"},
iW:{"^":"ce;aA:a<",
n:function(a,b,c){var z,y
H.c(c,{func:1,ret:P.h})
z=this.a
y=J.r(z)
if(!y.bf(z,b))y.j(z,b,H.m(c.$0()))
return y.a2(z,b)},
q:function(a,b){var z,y,x,w,v,u
H.c(b,{func:1,ret:-1,args:[P.h,P.h]})
for(z=this.gI(this),y=z.length,x=this.a,w=J.r(x),v=0;v<z.length;z.length===y||(0,H.cO)(z),++v){u=z[v]
b.$2(u,w.a2(x,u))}},
gI:function(a){var z,y,x,w,v
z=this.a.attributes
y=H.y([],[P.h])
for(x=z.length,w=0;w<x;++w){if(w>=z.length)return H.A(z,w)
v=H.d(z[w],"$isdZ")
if(v.namespaceURI==null)C.b.p(y,v.name)}return y},
$asab:function(){return[P.h,P.h]},
$asK:function(){return[P.h,P.h]}},
j_:{"^":"iW;a",
G:function(a,b){return J.eB(this.a,b)},
l:function(a,b){return J.bk(this.a,H.m(b))},
D:function(a,b,c){J.bT(this.a,b,H.m(c))},
gk:function(a){return this.gI(this).length}},
j0:{"^":"d2;aA:a<",
X:function(){var z,y,x,w,v
z=P.aQ(null,null,null,P.h)
for(y=this.a.className.split(" "),x=y.length,w=0;w<x;++w){v=J.cU(y[w])
if(v.length!==0)z.p(0,v)}return z},
b_:function(a){this.a.className=H.V(a,"$isac",[P.h],"$asac").aS(0," ")},
gk:function(a){return this.a.classList.length},
v:function(a,b){var z=this.a.classList.contains(b)
return z},
p:function(a,b){var z,y
H.m(b)
z=this.a.classList
y=z.contains(b)
z.add(b)
return!y},
aX:function(a,b,c){var z=this.a.classList.toggle(b)
return z},
aW:function(a,b){return this.aX(a,b,null)}},
j1:{"^":"ck;a,b,c,$ti"},
e0:{"^":"j1;a,b,c,$ti"},
j2:{"^":"iz;a,b,c,d,e,$ti",
cL:function(){var z,y,x
z=this.d
y=z!=null
if(y&&this.a<=0){x=this.b
x.toString
H.c(z,{func:1,args:[W.U]})
if(y)J.eA(x,this.c,z,!1)}},
m:{
R:function(a,b,c,d,e){var z=W.k8(new W.j3(c),W.U)
z=new W.j2(0,a,b,z,!1,[e])
z.cL()
return z}}},
j3:{"^":"a:22;a",
$1:[function(a){return this.a.$1(H.d(a,"$isU"))},null,null,4,0,null,19,"call"]},
ba:{"^":"b;a",
c3:function(a){var z,y
z=$.$get$ct()
if(z.gbz(z)){for(y=0;y<262;++y)z.D(0,C.S[y],W.kf())
for(y=0;y<12;++y)z.D(0,C.q[y],W.kg())}},
a4:function(a){return $.$get$e3().v(0,W.aM(a))},
a0:function(a,b,c){var z,y,x
z=W.aM(a)
y=$.$get$ct()
x=y.l(0,H.f(z)+"::"+b)
if(x==null)x=y.l(0,"*::"+b)
if(x==null)return!1
return H.cC(x.$4(a,b,c,this))},
$isa5:1,
m:{
e2:function(a){var z,y
z=document.createElement("a")
y=new W.jw(z,window.location)
y=new W.ba(y)
y.c3(a)
return y},
l0:[function(a,b,c,d){H.d(a,"$iso")
H.m(b)
H.m(c)
H.d(d,"$isba")
return!0},"$4","kf",16,0,11,3,4,5,6],
l1:[function(a,b,c,d){var z,y,x
H.d(a,"$iso")
H.m(b)
H.m(c)
z=H.d(d,"$isba").a
y=z.a
y.href=c
x=y.hostname
z=z.b
if(!(x==z.hostname&&y.port==z.port&&y.protocol==z.protocol))if(x==="")if(y.port===""){z=y.protocol
z=z===":"||z===""}else z=!1
else z=!1
else z=!0
return z},"$4","kg",16,0,11,3,4,5,6]}},
ag:{"^":"b;$ti",
gB:function(a){return new W.de(a,this.gk(a),-1,[H.a7(this,a,"ag",0)])}},
dr:{"^":"b;a",
a4:function(a){return C.b.bp(this.a,new W.ia(a))},
a0:function(a,b,c){return C.b.bp(this.a,new W.i9(a,b,c))},
$isa5:1},
ia:{"^":"a:15;a",
$1:function(a){return H.d(a,"$isa5").a4(this.a)}},
i9:{"^":"a:15;a,b,c",
$1:function(a){return H.d(a,"$isa5").a0(this.a,this.b,this.c)}},
jx:{"^":"b;",
c4:function(a,b,c,d){var z,y,x
this.a.M(0,c)
z=b.aZ(0,new W.jy())
y=b.aZ(0,new W.jz())
this.b.M(0,z)
x=this.c
x.M(0,C.U)
x.M(0,y)},
a4:function(a){return this.a.v(0,W.aM(a))},
a0:["c_",function(a,b,c){var z,y
z=W.aM(a)
y=this.c
if(y.v(0,H.f(z)+"::"+b))return this.d.cQ(c)
else if(y.v(0,"*::"+b))return this.d.cQ(c)
else{y=this.b
if(y.v(0,H.f(z)+"::"+b))return!0
else if(y.v(0,"*::"+b))return!0
else if(y.v(0,H.f(z)+"::*"))return!0
else if(y.v(0,"*::*"))return!0}return!1}],
$isa5:1},
jy:{"^":"a:16;",
$1:function(a){return!C.b.v(C.q,H.m(a))}},
jz:{"^":"a:16;",
$1:function(a){return C.b.v(C.q,H.m(a))}},
jE:{"^":"jx;e,a,b,c,d",
a0:function(a,b,c){if(this.c_(a,b,c))return!0
if(b==="template"&&c==="")return!0
if(J.bk(a,"template")==="")return this.e.v(0,b)
return!1},
m:{
ea:function(){var z,y,x,w,v
z=P.h
y=P.dn(C.p,z)
x=H.i(C.p,0)
w=H.c(new W.jF(),{func:1,ret:z,args:[x]})
v=H.y(["TEMPLATE"],[z])
y=new W.jE(y,P.aQ(null,null,null,z),P.aQ(null,null,null,z),P.aQ(null,null,null,z),null)
y.c4(null,new H.bD(C.p,w,[x,z]),v,null)
return y}}},
jF:{"^":"a:25;",
$1:[function(a){return"TEMPLATE::"+H.f(H.m(a))},null,null,4,0,null,20,"call"]},
jC:{"^":"b;",
a4:function(a){var z=J.u(a)
if(!!z.$isdy)return!1
z=!!z.$iscl
if(z&&W.aM(a)==="foreignObject")return!1
if(z)return!0
return!1},
a0:function(a,b,c){if(b==="is"||C.k.bR(b,"on"))return!1
return this.a4(a)},
$isa5:1},
de:{"^":"b;a,b,c,0d,$ti",
sbg:function(a){this.d=H.l(a,H.i(this,0))},
t:function(){var z,y
z=this.c+1
y=this.b
if(z<y){this.sbg(J.cP(this.a,z))
this.c=z
return!0}this.sbg(null)
this.c=y
return!1},
gw:function(){return this.d},
$isah:1},
iY:{"^":"b;a",$isaN:1,m:{
iZ:function(a){if(a===window)return a
else return new W.iY(a)}}},
a5:{"^":"b;"},
jw:{"^":"b;a,b",$iskW:1},
ec:{"^":"b;a",
b0:function(a){new W.jM(this).$2(a,null)},
a9:function(a,b){if(b==null)J.bS(a)
else J.bh(b,a)},
cF:function(a,b){var z,y,x,w,v,u,t,s
z=!0
y=null
x=null
try{y=J.eE(a)
x=J.bk(y.gaA(),"is")
H.d(a,"$iso")
w=function(c){if(!(c.attributes instanceof NamedNodeMap))return true
var r=c.childNodes
if(c.lastChild&&c.lastChild!==r[r.length-1])return true
if(c.children)if(!(c.children instanceof HTMLCollection||c.children instanceof NodeList))return true
var q=0
if(c.children)q=c.children.length
for(var p=0;p<q;p++){var o=c.children[p]
if(o.id=='attributes'||o.name=='attributes'||o.id=='lastChild'||o.name=='lastChild'||o.id=='children'||o.name=='children')return true}return false}(a)
z=w?!0:!(a.attributes instanceof NamedNodeMap)}catch(t){H.N(t)}v="element unprintable"
try{v=J.B(a)}catch(t){H.N(t)}try{u=W.aM(a)
this.cE(H.d(a,"$iso"),b,z,v,u,H.d(y,"$isK"),H.m(x))}catch(t){if(H.N(t) instanceof P.a8)throw t
else{this.a9(a,b)
window
s="Removing corrupted element "+H.f(v)
if(typeof console!="undefined")window.console.warn(s)}}},
cE:function(a,b,c,d,e,f,g){var z,y,x,w,v,u,t
if(c){this.a9(a,b)
window
z="Removing element due to corrupted attributes on <"+d+">"
if(typeof console!="undefined")window.console.warn(z)
return}if(!this.a.a4(a)){this.a9(a,b)
window
z="Removing disallowed element <"+H.f(e)+"> from "+H.f(b)
if(typeof console!="undefined")window.console.warn(z)
return}if(g!=null)if(!this.a.a0(a,"is",g)){this.a9(a,b)
window
z="Removing disallowed type extension <"+H.f(e)+' is="'+g+'">'
if(typeof console!="undefined")window.console.warn(z)
return}z=f.gI(f)
y=H.y(z.slice(0),[H.i(z,0)])
for(x=f.gI(f).length-1,z=f.a,w=J.r(z);x>=0;--x){if(x>=y.length)return H.A(y,x)
v=y[x]
u=this.a
t=J.eM(v)
H.m(v)
if(!u.a0(a,t,w.a2(z,v))){window
u="Removing disallowed attribute <"+H.f(e)+" "+H.f(v)+'="'+H.f(w.a2(z,v))+'">'
if(typeof console!="undefined")window.console.warn(u)
w.a2(z,v)
w.cB(z,v)}}if(!!J.u(a).$isdF)this.b0(a.content)},
$iskR:1},
jM:{"^":"a:26;a",
$2:function(a,b){var z,y,x,w,v,u
x=this.a
switch(a.nodeType){case 1:x.cF(a,b)
break
case 8:case 11:case 3:case 4:break
default:x.a9(a,b)}z=a.lastChild
for(x=a==null;null!=z;){y=null
try{y=J.eG(z)}catch(w){H.N(w)
v=H.d(z,"$isn")
if(x){u=v.parentNode
if(u!=null)J.bh(u,v)}else J.bh(a,v)
z=null
y=a.lastChild}if(z!=null)this.$2(z,a)
z=H.d(y,"$isn")}}},
iX:{"^":"x+fe;"},
ji:{"^":"x+I;"},
jj:{"^":"ji+ag;"},
jq:{"^":"x+I;"},
jr:{"^":"jq+ag;"},
jA:{"^":"x+ab;"},
jO:{"^":"x+I;"},
jP:{"^":"jO+ag;"}}],["","",,P,{"^":"",
d9:function(){var z=$.d8
if(z==null){z=J.bR(window.navigator.userAgent,"Opera",0)
$.d8=z}return z},
fi:function(){var z,y
z=$.d5
if(z!=null)return z
y=$.d6
if(y==null){y=J.bR(window.navigator.userAgent,"Firefox",0)
$.d6=y}if(y)z="-moz-"
else{y=$.d7
if(y==null){y=!P.d9()&&J.bR(window.navigator.userAgent,"Trident/",0)
$.d7=y}if(y)z="-ms-"
else z=P.d9()?"-o-":"-webkit-"}$.d5=z
return z},
d2:{"^":"dz;",
aN:function(a){var z=$.$get$d3().b
if(typeof a!=="string")H.S(H.aH(a))
if(z.test(a))return a
throw H.e(P.bl(a,"value","Not a valid class token"))},
i:function(a){return this.X().aS(0," ")},
aX:function(a,b,c){var z,y,x
this.aN(b)
z=this.X()
y=z.v(0,b)
if(!y){z.p(0,b)
x=!0}else{z.R(0,b)
x=!1}this.b_(z)
return x},
aW:function(a,b){return this.aX(a,b,null)},
gB:function(a){var z=this.X()
return P.jo(z,z.r,H.i(z,0))},
gk:function(a){return this.X().a},
v:function(a,b){this.aN(b)
return this.X().v(0,b)},
p:function(a,b){H.m(b)
this.aN(b)
return H.cC(this.dl(new P.fc(b)))},
C:function(a,b){return this.X().C(0,b)},
dl:function(a){var z,y
H.c(a,{func:1,args:[[P.ac,P.h]]})
z=this.X()
y=a.$1(z)
this.b_(z)
return y},
$asci:function(){return[P.h]},
$asp:function(){return[P.h]},
$asac:function(){return[P.h]}},
fc:{"^":"a:27;a",
$1:function(a){return H.V(a,"$isac",[P.h],"$asac").p(0,this.a)}},
fK:{"^":"cd;a,b",
gaj:function(){var z,y,x
z=this.b
y=H.aY(z,"I",0)
x=W.o
return new H.i2(new H.co(z,H.c(new P.fL(),{func:1,ret:P.z,args:[y]}),[y]),H.c(new P.fM(),{func:1,ret:x,args:[y]}),[y,x])},
q:function(a,b){H.c(b,{func:1,ret:-1,args:[W.o]})
C.b.q(P.ay(this.gaj(),!1,W.o),b)},
gk:function(a){return J.a1(this.gaj().a)},
l:function(a,b){var z=this.gaj()
return z.b.$1(J.bi(z.a,b))},
gB:function(a){var z=P.ay(this.gaj(),!1,W.o)
return new J.bm(z,z.length,0,[H.i(z,0)])},
$asI:function(){return[W.o]},
$asp:function(){return[W.o]},
$ast:function(){return[W.o]}},
fL:{"^":"a:12;",
$1:function(a){return!!J.u(H.d(a,"$isn")).$iso}},
fM:{"^":"a:28;",
$1:[function(a){return H.cK(H.d(a,"$isn"),"$iso")},null,null,4,0,null,21,"call"]}}],["","",,P,{"^":"",dj:{"^":"x;",$isdj:1,"%":"IDBKeyRange"}}],["","",,P,{"^":"",
jT:[function(a,b,c,d){var z,y,x
H.cC(b)
H.aZ(d)
if(b){z=[c]
C.b.M(z,d)
d=z}y=P.ay(J.eI(d,P.kp(),null),!0,null)
H.d(a,"$isaf")
x=H.ih(a,y)
return P.jU(x)},null,null,16,0,null,22,23,24,25],
cw:function(a,b,c){var z
try{if(Object.isExtensible(a)&&!Object.prototype.hasOwnProperty.call(a,b)){Object.defineProperty(a,b,{value:c})
return!0}}catch(z){H.N(z)}return!1},
ef:function(a,b){if(Object.prototype.hasOwnProperty.call(a,b))return a[b]
return},
jU:[function(a){var z
if(a==null||typeof a==="string"||typeof a==="number"||typeof a==="boolean")return a
z=J.u(a)
if(!!z.$isai)return a.a
if(H.es(a))return a
if(!!z.$isdS)return a
if(!!z.$isc_)return H.am(a)
if(!!z.$isaf)return P.ee(a,"$dart_jsFunction",new P.jV())
return P.ee(a,"_$dart_jsObject",new P.jW($.$get$cv()))},"$1","kq",4,0,6,7],
ee:function(a,b,c){var z
H.c(c,{func:1,args:[,]})
z=P.ef(a,b)
if(z==null){z=c.$1(a)
P.cw(a,b,z)}return z},
ed:[function(a){var z,y
if(a==null||typeof a=="string"||typeof a=="number"||typeof a=="boolean")return a
else if(a instanceof Object&&H.es(a))return a
else if(a instanceof Object&&!!J.u(a).$isdS)return a
else if(a instanceof Date){z=H.M(a.getTime())
if(Math.abs(z)<=864e13)y=!1
else y=!0
if(y)H.S(P.bU("DateTime is outside valid range: "+z))
return new P.c_(z,!1)}else if(a.constructor===$.$get$cv())return a.o
else return P.el(a)},"$1","kp",4,0,36,7],
el:function(a){if(typeof a=="function")return P.cx(a,$.$get$bq(),new P.k5())
if(a instanceof Array)return P.cx(a,$.$get$cs(),new P.k6())
return P.cx(a,$.$get$cs(),new P.k7())},
cx:function(a,b,c){var z
H.c(c,{func:1,args:[,]})
z=P.ef(a,b)
if(z==null||!(a instanceof Object)){z=c.$1(a)
P.cw(a,b,z)}return z},
ai:{"^":"b;a",
l:["bY",function(a,b){if(typeof b!=="number")throw H.e(P.bU("property is not a String or num"))
return P.ed(this.a[b])}],
gE:function(a){return 0},
T:function(a,b){if(b==null)return!1
return b instanceof P.ai&&this.a===b.a},
i:function(a){var z,y
try{z=String(this.a)
return z}catch(y){H.N(y)
z=this.bZ(this)
return z}},
cT:function(a,b){var z,y
z=this.a
if(b==null)y=null
else{y=H.i(b,0)
y=P.ay(new H.bD(b,H.c(P.kq(),{func:1,ret:null,args:[y]}),[y,null]),!0,null)}return P.ed(z[a].apply(z,y))},
br:function(a){return this.cT(a,null)}},
cb:{"^":"ai;a"},
ca:{"^":"jk;a,$ti",
cd:function(a){var z=a<0||a>=this.gk(this)
if(z)throw H.e(P.az(a,0,this.gk(this),null,null))},
l:function(a,b){if(typeof b==="number"&&b===C.f.dz(b))this.cd(b)
return H.l(this.bY(0,b),H.i(this,0))},
gk:function(a){var z=this.a.length
if(typeof z==="number"&&z>>>0===z)return z
throw H.e(P.aT("Bad JsArray length"))},
$isp:1,
$ist:1},
jV:{"^":"a:6;",
$1:function(a){var z
H.d(a,"$isaf")
z=function(b,c,d){return function(){return b(c,d,this,Array.prototype.slice.apply(arguments))}}(P.jT,a,!1)
P.cw(z,$.$get$bq(),a)
return z}},
jW:{"^":"a:6;a",
$1:function(a){return new this.a(a)}},
k5:{"^":"a:29;",
$1:function(a){return new P.cb(a)}},
k6:{"^":"a:30;",
$1:function(a){return new P.ca(a,[null])}},
k7:{"^":"a:31;",
$1:function(a){return new P.ai(a)}},
jk:{"^":"ai+I;"}}],["","",,P,{"^":"",dy:{"^":"cl;",$isdy:1,"%":"SVGScriptElement"},eY:{"^":"d2;a",
X:function(){var z,y,x,w,v,u
z=J.bk(this.a,"class")
y=P.aQ(null,null,null,P.h)
if(z==null)return y
for(x=z.split(" "),w=x.length,v=0;v<w;++v){u=J.cU(x[v])
if(u.length!==0)y.p(0,u)}return y},
b_:function(a){J.bT(this.a,"class",a.aS(0," "))}},cl:{"^":"o;",
gac:function(a){return new P.eY(a)},
gbt:function(a){return new P.fK(a,new W.Y(a))},
O:function(a,b,c,d){var z,y,x,w,v,u
z=H.y([],[W.a5])
C.b.p(z,W.e2(null))
C.b.p(z,W.ea())
C.b.p(z,new W.jC())
c=new W.ec(new W.dr(z))
y='<svg version="1.1">'+b+"</svg>"
z=document
x=z.body
w=(x&&C.n).cY(x,y,c)
v=z.createDocumentFragment()
w.toString
z=new W.Y(w)
u=z.ga3(z)
for(z=J.r(v);x=u.firstChild,x!=null;)z.h(v,x)
return v},
bx:function(a,b,c){throw H.e(P.Q("Cannot invoke insertAdjacentElement on SVG."))},
gbD:function(a){return new W.e0(a,"click",!1,[W.T])},
$iscl:1,
"%":"SVGAElement|SVGAnimateElement|SVGAnimateMotionElement|SVGAnimateTransformElement|SVGAnimationElement|SVGCircleElement|SVGClipPathElement|SVGComponentTransferFunctionElement|SVGDefsElement|SVGDescElement|SVGDiscardElement|SVGEllipseElement|SVGFEBlendElement|SVGFEColorMatrixElement|SVGFEComponentTransferElement|SVGFECompositeElement|SVGFEConvolveMatrixElement|SVGFEDiffuseLightingElement|SVGFEDisplacementMapElement|SVGFEDistantLightElement|SVGFEDropShadowElement|SVGFEFloodElement|SVGFEFuncAElement|SVGFEFuncBElement|SVGFEFuncGElement|SVGFEFuncRElement|SVGFEGaussianBlurElement|SVGFEImageElement|SVGFEMergeElement|SVGFEMergeNodeElement|SVGFEMorphologyElement|SVGFEOffsetElement|SVGFEPointLightElement|SVGFESpecularLightingElement|SVGFESpotLightElement|SVGFETileElement|SVGFETurbulenceElement|SVGFilterElement|SVGForeignObjectElement|SVGGElement|SVGGeometryElement|SVGGradientElement|SVGGraphicsElement|SVGImageElement|SVGLineElement|SVGLinearGradientElement|SVGMPathElement|SVGMarkerElement|SVGMaskElement|SVGMetadataElement|SVGPathElement|SVGPatternElement|SVGPolygonElement|SVGPolylineElement|SVGRadialGradientElement|SVGRectElement|SVGSVGElement|SVGSetElement|SVGStopElement|SVGStyleElement|SVGSwitchElement|SVGSymbolElement|SVGTSpanElement|SVGTextContentElement|SVGTextElement|SVGTextPathElement|SVGTextPositioningElement|SVGTitleElement|SVGUseElement|SVGViewElement;SVGElement"}}],["","",,P,{"^":""}],["","",,P,{"^":""}],["","",,P,{"^":""}],["","",,M,{"^":"",eO:{"^":"b;a,b,c,d,e",
ap:function(){var z,y
z=J.a2(C.h.J(document,"#button_to_menu"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new M.eU(this),{func:1,ret:-1,args:[y]}),!1,y)},
dg:function(){var z,y
z=J.a2(C.h.J(document,"#button_to_menu"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new M.eT(this),{func:1,ret:-1,args:[y]}),!1,y)},
dj:function(){var z,y
z=J.a2(C.h.J(document,"#button_start_level"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new M.eX(this),{func:1,ret:-1,args:[y]}),!1,y)},
dh:function(){var z,y
z=J.a2(C.h.J(document,"#button_next_level"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new M.eV(this),{func:1,ret:-1,args:[y]}),!1,y)},
di:function(){var z,y
z=J.a2(C.h.J(document,"#button_pevious_level"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new M.eW(this),{func:1,ret:-1,args:[y]}),!1,y)},
dd:function(){var z,y
z=J.a2(C.h.J(document,"#button_choose_levels"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new M.eQ(this),{func:1,ret:-1,args:[y]}),!1,y)},
dc:function(a){var z,y,x,w
z=0
while(!0){y=this.c
if(typeof y!=="number")return H.j(y)
if(!(z<y))break
x=z+1
y="#level-"+x
y=J.a2(C.h.J(document,y))
w=H.i(y,0)
W.R(y.a,y.b,H.c(new M.eP(this,z),{func:1,ret:-1,args:[w]}),!1,w)
z=x}},
de:function(){var z,y
z=J.a2(C.h.J(document,"#button_credits"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new M.eR(this),{func:1,ret:-1,args:[y]}),!1,y)},
df:function(){var z,y
z=J.a2(C.h.J(document,"#donate-button"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new M.eS(),{func:1,ret:-1,args:[y]}),!1,y)},
a_:function(){var z,y,x,w,v,u,t,s,r,q,p,o
z=new N.ak()
y=this.b
x=this.cs(y)
w=document
v=w.createElement("div")
C.a.j(v,"id","button_start_level")
C.a.j(v,"class","message")
C.a.h(v,z.U())
C.a.h(v,w.createElement("hr"))
u=w.createElement("h2")
C.l.h(u,w.createTextNode("Level"))
C.a.h(v,u)
t=w.createElement("h1")
C.l.a5(t,H.f(y))
y=t.style
y.marginTop="1vh"
y=t.style
C.u.cG(y,(y&&C.u).cb(y,"text-shadow"),"0.04em 0.04em rgb(137,137,137)","")
C.a.h(v,t)
s=w.createElement("p")
C.e.h(s,w.createTextNode(x))
C.a.h(v,s)
C.a.h(v,w.createElement("hr"))
r=w.createElement("p")
C.e.j(r,"class","tap-me")
C.e.h(r,w.createTextNode("Tap To Play"))
C.a.h(v,r)
q=w.createElement("button")
C.c.j(q,"id","button_choose_levels")
C.c.j(q,"class","upper-bottom-button")
C.c.h(q,w.createTextNode("Choose a Level"))
p=w.createElement("button")
C.c.j(p,"id","button_credits")
C.c.j(p,"class","lower-bottom-button")
C.c.h(p,w.createTextNode("Credits"))
o=w.createElement("div")
C.a.h(o,v)
v=w.createElement("div")
C.a.j(v,"class","button-box")
C.a.j(v,"style","height: 20%")
C.c.j(q,"style","height: 50%")
C.c.j(p,"style","height: 50%")
C.a.h(v,q)
C.a.h(v,p)
C.a.h(o,v)
z.a=o
z.K()
this.dj()
this.dd()
this.de()},
au:function(a){var z
this.b=a
z=this.c
if(typeof z!=="number")return H.j(z)
if(a>z){z=this.a;(z&&C.j).aa(z,"reachedLevel",C.f.i(a))
this.c=a}},
cs:function(a){var z,y,x
switch(a){case 1:return"Get in Rhythm and catch all dots to win! "
case 2:return"This time, try to avoid the bricks and survive until the end!"
case 3:return"Choose wisely. The barriers are your friends."
case 4:return"Now you are on your own. Try to reach Level 500!"
default:z="highscore_level_"+J.B(a)
y=this.a
x=(y&&C.j).F(y,z)!=null?P.bf(C.j.F(y,z),null,null):0
if(typeof x!=="number")return x.as()
return x>0?"Highscore: "+x:"No Highscore yet"}}},eU:{"^":"a:3;a",
$1:function(a){H.d(a,"$isT")
this.a.a_()
$.$get$cF().br("requestiOSGyro")}},eT:{"^":"a:3;a",
$1:function(a){var z,y
H.d(a,"$isT")
this.a.a_()
try{document.body.webkitRequestFullscreen()
z=window.screen.orientation
z.toString
W.kw(z.lock("portrait-primary"),null)}catch(y){H.N(y)
H.kv("You better use Chrome ;)")}$.$get$cF().br("requestiOSGyro")}},eX:{"^":"a:3;a",
$1:function(a){var z
H.d(a,"$isT")
z=this.a
N.b7(z,z.b)}},eV:{"^":"a:3;a",
$1:function(a){var z,y,x,w,v,u,t,s
H.d(a,"$isT")
z=this.a
y=z.b
if(typeof y!=="number")return y.A()
z.au(y+1)
y=z.b
if(typeof y!=="number")return y.as()
if(y>z.d){x=new N.ak()
w=document
v=w.createElement("div")
C.a.j(v,"class","message")
C.a.h(v,x.U())
C.a.h(v,w.createElement("hr"))
u=w.createElement("p")
C.e.h(u,w.createTextNode("The level "+y+" is not available yet."))
C.a.h(v,u)
C.a.h(v,w.createElement("hr"))
t=w.createElement("button")
C.c.j(t,"id","button_pevious_level")
C.c.j(t,"class","lower-bottom-button")
C.c.h(t,w.createTextNode("Return to last Level"))
s=w.createElement("div")
C.a.h(s,v)
v=w.createElement("div")
C.a.j(v,"class","button-box")
C.a.j(v,"style","height: 10%")
C.c.j(t,"style","height: 100%")
C.a.h(v,t)
C.a.h(s,v)
x.a=s
x.K()
z.di()}else z.a_()}},eW:{"^":"a:3;a",
$1:function(a){var z,y
H.d(a,"$isT")
z=this.a
y=z.b
if(typeof y!=="number")return y.aw()
z.au(y-1)
z.a_()}},eQ:{"^":"a:3;a",
$1:function(a){var z,y
H.d(a,"$isT")
z=this.a
y=z.c
new N.ak().cU(z.d,y).K()
z.ap()
z.dc(y)}},eP:{"^":"a:33;a,b",
$1:function(a){var z
a.preventDefault()
z=this.a
z.au(this.b+1)
z.a_()}},eR:{"^":"a:3;a",
$1:function(a){var z,y,x,w,v,u,t,s,r,q,p,o
H.d(a,"$isT")
z=this.a
y=new N.ak()
x=document
w=x.createElement("div")
C.a.j(w,"class","message")
C.a.h(w,y.U())
C.a.h(w,x.createElement("hr"))
v=x.createElement("p")
C.e.h(v,x.createTextNode("Built with \u2764 in L\xfcbeck."))
C.a.h(w,v)
u=x.createElement("p")
C.e.h(u,x.createTextNode("Jan Steffen Krohn & Tom Christopher B\xf6ttger"))
C.a.h(w,u)
C.a.h(w,x.createElement("hr"))
t=x.createElement("p")
C.e.j(t,"class","donate-text")
C.e.h(t,x.createTextNode("Help us making Dozer even better and donate us a coffee :-)"))
C.a.h(w,t)
s=W.c4(null,"resources/paypal.png",null)
r=x.createElement("span")
r.textContent="Donate"
q=x.createElement("button")
C.c.j(q,"id","donate-button")
C.c.j(q,"class","upper-bottom-button")
C.c.h(q,s)
C.c.h(q,r)
p=x.createElement("button")
C.c.j(p,"id","button_to_menu")
C.c.j(p,"class","lower-bottom-button")
C.c.h(p,x.createTextNode("Return"))
o=x.createElement("div")
C.a.h(o,w)
w=x.createElement("div")
C.a.j(w,"class","button-box")
C.a.j(w,"style","height: 20%")
C.c.j(q,"style","height: 50%")
C.c.j(p,"style","height: 50%")
C.a.h(w,q)
C.a.h(w,p)
C.a.h(o,w)
y.a=o
y.K()
z.ap()
z.df()}},eS:{"^":"a:3;",
$1:function(a){H.d(a,"$isT")
C.X.dm(window,"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EW22STTHR8DK2&source=url","Donate on PayPal")}}}],["","",,N,{"^":"",dl:{"^":"b;0a,0b,0c,d,0e",
cI:function(){if(this.a.e)this.cj()
else this.ci()
this.cw()
this.e=P.iH(P.av(0,0,0,25,0,0),new N.hg(this))},
ci:function(){var z=W.b6
W.R(window,"keydown",H.c(new N.hd(this),{func:1,ret:-1,args:[z]}),!1,z)},
cj:function(){var z=W.b1
W.R(window,"deviceorientation",H.c(new N.he(this),{func:1,ret:-1,args:[z]}),!1,z)},
aF:function(){var z=0,y=P.F(null),x,w=this,v,u,t
var $async$aF=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:v="tries_level_"+J.B(w.b.b)
u=w.d
t=(u&&C.j).F(u,v)!=null?P.bf(C.j.F(u,v),null,null):0
if(typeof t!=="number"){x=t.A()
z=1
break}++t
C.j.aa(u,v,C.f.i(t))
w.b.r=t
z=1
break
case 1:return P.D(x,y)}})
return P.E($async$aF,y)},
cw:function(){var z,y
z=J.a2(C.h.J(document,"#button_back_in_level"))
y=H.i(z,0)
W.R(z.a,z.b,H.c(new N.hf(this),{func:1,ret:-1,args:[y]}),!1,y)},
m:{
b7:function(a,b){var z=0,y=P.F(null),x
var $async$b7=P.G(function(c,d){if(c===1)return P.C(d,y)
while(true)switch(z){case 0:z=2
return P.bb(N.by(a,b),$async$b7)
case 2:x=d
z=3
return P.bb(x.cI(),$async$b7)
case 3:x.aF()
return P.D(null,y)}})
return P.E($async$b7,y)},
by:function(a,b){var z=0,y=P.F(N.dl),x,w,v,u,t,s,r,q,p,o,n,m,l,k
var $async$by=P.G(function(c,d){if(c===1)return P.C(d,y)
while(true)switch(z){case 0:w=new N.dl(window.localStorage)
w.a=a
z=3
return P.bb(new L.hh().af(b),$async$by)
case 3:v=d
w.b=v
u=new T.hG(new H.b5(0,0,[P.h,W.o]),!1,!1)
u.a=v
t=document
s=t.createElement("div")
C.a.j(s,"id","lane")
u.b=s
r=C.h.J(t,"body")
q=J.r(r)
q.a5(r,"")
q.h(r,s)
r=t.createElement("div")
C.a.j(r,"class","visual-bar")
u.c=r
p=W.c4(null,"resources/back.svg",null)
C.v.j(p,"id","button_back_in_level")
o=t.createElement("div")
C.a.j(o,"class","progress-bar")
n=t.createElement("div")
C.a.j(n,"class","level first-level")
q=v.b
C.a.h(n,t.createTextNode(J.B(q)))
m=t.createElement("progress")
H.d(m,"$isch")
C.r.j(m,"class","score-progress")
C.r.j(m,"min","0")
C.r.j(m,"max",J.B(v.f))
l=t.createElement("div")
C.a.j(l,"class","level next-level")
if(typeof q!=="number"){x=q.A()
z=1
break}C.a.h(l,t.createTextNode(C.f.i(q+1)))
k=t.createElement("span")
C.m.j(k,"class","countdown")
C.m.h(k,t.createTextNode(C.o.bI(v.c/1000,2)))
C.a.h(o,n)
C.a.h(o,m)
C.a.h(o,l)
C.a.h(r,p)
C.a.h(r,o)
C.a.h(r,k)
C.a.h(s,r)
w.c=u
x=w
z=1
break
case 1:return P.D(x,y)}})
return P.E($async$by,y)}}},hg:{"^":"a:34;a",
$1:function(a){var z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g
H.d(a,"$isaB")
z=this.a
y=z.b
y.c+=y.cy?-12.5:-25
z.c.K()
z.b.S(0)
y=z.b
if(!(y.c<=0)){x=y.a.y
if(typeof x!=="number")return x.bP()
x=x<=0}else x=!0
if(x){z.e.aQ()
y=z.a
z=z.b.c
y.toString
x=new N.ak()
w=z<=0?"Be faster and grow your dozer bigger next time!":"Your Dozer did not make it, avoid the dangerous bricks next time!"
z=document
v=z.createElement("div")
C.a.j(v,"id","button_to_menu")
C.a.j(v,"class","message")
C.a.h(v,x.U())
C.a.h(v,z.createElement("hr"))
u=z.createElement("h2")
C.l.h(u,z.createTextNode("You Lost!"))
C.a.h(v,u)
t=z.createElement("span")
C.m.h(t,z.createTextNode(w))
s=t.style
s.fontStyle="italic"
C.a.h(v,t)
r=z.createElement("hr")
s=r.style
s.marginTop="3vh"
C.a.h(v,r)
q=z.createElement("p")
C.e.j(q,"class","tap-me")
C.e.h(q,z.createTextNode("Tap To Continue"))
C.a.h(v,q)
p=z.createElement("div")
C.a.h(p,v)
x.a=p
x.K()
y.ap()
return}x=y.a.y
y=y.f
if(typeof x!=="number")return x.bO()
if(typeof y!=="number")return H.j(y)
if(x>=y){z.e.aQ()
y=z.a
x=z.b.ag()
o="highscore_level_"+J.B(z.b.b)
s=z.d
if((s&&C.j).F(s,o)!=null){n=P.bf(C.j.F(s,o),null,null)
m=z.b.ag()
if(typeof n!=="number")return n.Z()
l=n<m&&!0}else{n=0
l=!0}if(n<z.b.ag())C.j.aa(s,o,C.f.i(z.b.ag()))
z=z.b.r
y.toString
s=new N.ak()
k=l?"New Highsore":"Your Score"
m=document
v=m.createElement("div")
C.a.j(v,"id","button_next_level")
C.a.j(v,"class","message")
C.a.h(v,s.U())
C.a.h(v,m.createElement("hr"))
u=m.createElement("h2")
C.l.h(u,m.createTextNode("You Won!"))
C.a.h(v,u)
t=m.createElement("span")
C.m.h(t,m.createTextNode(k))
j=t.style
j.fontStyle="italic"
C.a.h(v,t)
i=m.createElement("p")
C.e.h(i,m.createTextNode(C.f.i(x)))
C.e.j(i,"class","highscore")
C.a.h(v,i)
if(l){if(typeof z!=="number")return z.as()
h=z>1?"It took you "+z+" tries!":"Unbelievable, with your first try!"
g=m.createElement("p")
C.e.h(g,m.createTextNode(h))
C.a.h(v,g)}C.a.h(v,m.createElement("hr"))
q=m.createElement("p")
C.e.j(q,"class","tap-me")
C.e.h(q,m.createTextNode("Tap To Continue"))
C.a.h(v,q)
p=m.createElement("div")
C.a.h(p,v)
s.a=p
s.K()
y.dh()
return}}},hd:{"^":"a:35;a",
$1:function(a){var z
H.d(a,"$isb6")
if(a.keyCode===37){z=this.a.b.a
z.c=-10
z.d=0}if(a.keyCode===39){z=this.a.b.a
z.c=10
z.d=0}if(a.keyCode===38){z=this.a.b.a
z.c=0
z.d=0}}},he:{"^":"a:55;a",
$1:function(a){var z,y
H.d(a,"$isb1")
z=this.a.b.a
y=a.gamma
if(typeof y!=="number")return y.ae()
z.c=y/4
z.d=0}},hf:{"^":"a:3;a",
$1:function(a){var z
H.d(a,"$isT")
z=this.a
z.e.aQ()
z.a.a_()}}}],["","",,L,{"^":"",hh:{"^":"b;0a",
af:function(a){var z=0,y=P.F(Q.dk),x,w=this,v,u,t,s,r
var $async$af=P.G(function(b,c){if(b===1)return P.C(c,y)
while(true)switch(z){case 0:v={}
z=3
return P.bb(L.bz(a),$async$af)
case 3:u=c
t=J.r(u)
w.cg(H.d(t.n(u,"params",new L.hD()),"$isK"))
s=H.aZ(t.n(u,"entities",new L.hE()))
r=H.y([],[O.v])
v.a=1
J.cR(s,new L.hF(v,w,r))
w.a.sds(r)
x=w.a
z=1
break
case 1:return P.D(x,y)}})
return P.E($async$af,y)},
cg:function(a){var z=J.r(a)
this.a=Q.hc(H.W(z.n(a,"timelimit",new L.hi())),H.W(z.n(a,"initialscore",new L.hj())),H.W(z.n(a,"targetscore",new L.hk())),H.kc(z.n(a,"lanespeed",new L.hl())),H.W(z.n(a,"level",new L.hm())),J.cQ(window.innerHeight),J.cQ(window.innerWidth))},
co:function(a,b){var z,y,x,w,v,u,t,s,r
z=this.a.Q
y=C.d.u(z*0.05)
x=J.r(b)
w=H.b_(x.n(b,"x",new L.ht()))
if(typeof w!=="number")return H.j(w)
v=this.a.Y(H.W(x.n(b,"time",new L.hu())))
x=H.W(x.n(b,"value",new L.hv()))
u=C.d.u(this.a.Q*0.05)
t=C.d.u(this.a.Q*0.05)
s=this.a
r=new F.bs(0,0,0)
r.b=a
r.e=(z-y)*w
r.f=v
r.y=x
r.r=u
r.x=t
r.a=s
return r},
cn:function(a,b){var z,y,x,w,v,u,t,s,r
z=this.a.Q
y=C.d.u(z*0.25)
x=J.r(b)
w=H.b_(x.n(b,"x",new L.hq()))
if(typeof w!=="number")return H.j(w)
v=this.a.Y(H.W(x.n(b,"time",new L.hr())))
x=H.W(x.n(b,"value",new L.hs()))
u=C.d.u(this.a.Q*0.25)
t=C.d.u(this.a.ch*0.07)
s=this.a
r=new X.bp(0,0,0)
r.b=a
r.e=(z-y)*w
r.f=v
r.y=x
r.r=u
r.x=t
r.a=s
return r},
cm:function(a,b){var z,y,x,w,v,u,t,s
z=this.a.Q
y=C.d.u(z*0.01)
x=J.r(b)
w=-1*C.d.u(this.a.Y(H.W(x.n(b,"height",new L.hn()))))
v=H.b_(x.n(b,"x",new L.ho()))
if(typeof v!=="number")return H.j(v)
x=this.a.Y(H.W(x.n(b,"time",new L.hp())))
u=C.d.u(this.a.Q*0.01)
t=this.a
s=new D.bV(0,0,0)
s.b=a
s.e=(z-y)*v
s.f=x-w
s.r=u
s.x=w
s.a=t
return s},
cp:function(a,b){var z,y,x,w,v,u,t
z=this.a.Q
y=z-C.d.u(z*0.05)
z=J.r(b)
x=H.b_(z.n(b,"x",new L.hw()))
if(typeof x!=="number")return H.j(x)
z=this.a.Y(H.W(z.n(b,"time",new L.hx())))
w=y*0.05
v=C.d.u(w)
w=C.d.u(w)
u=this.a
t=new Z.da(5000,0,0,0)
t.b=a
t.e=y*x
t.f=z
t.r=v
t.x=w
t.a=u
return t},
ct:function(a,b){var z,y,x,w,v,u,t
z=this.a.Q
y=z-C.d.u(z*0.05)
z=J.r(b)
x=H.b_(z.n(b,"x",new L.hA()))
if(typeof x!=="number")return H.j(x)
z=this.a.Y(H.W(z.n(b,"time",new L.hB())))
w=y*0.05
v=C.d.u(w)
w=C.d.u(w)
u=this.a
t=new A.dA(5000,0,0,0)
t.b=a
t.e=y*x
t.f=z
t.r=v
t.x=w
t.a=u
return t},
cq:function(a,b){var z,y,x,w,v,u,t
z=this.a.Q
y=z-C.d.u(z*0.05)
z=J.r(b)
x=H.b_(z.n(b,"x",new L.hy()))
if(typeof x!=="number")return H.j(x)
z=this.a.Y(H.W(z.n(b,"time",new L.hz())))
w=y*0.05
v=C.d.u(w)
w=C.d.u(w)
u=this.a
t=new G.db(5000,0,0,0)
t.b=a
t.e=y*x
t.f=z
t.r=v
t.x=w
t.a=u
return t},
m:{
bz:function(a){var z=0,y=P.F([P.K,,,]),x,w,v
var $async$bz=P.G(function(b,c){if(b===1)return P.C(c,y)
while(true)switch(z){case 0:w=H
v=C.Q
z=3
return P.bb(W.fU("resources/level/level"+J.B(a)+".json",null,null),$async$bz)
case 3:x=w.ad(v.d_(0,c),{futureOr:1,type:[P.K,,,]})
z=1
break
case 1:return P.D(x,y)}})
return P.E($async$bz,y)}}},hD:{"^":"a:1;",
$0:function(){return}},hE:{"^":"a:37;",
$0:function(){return[]}},hF:{"^":"a:2;a,b,c",
$1:function(a){var z,y,x,w
z=H.m(J.eK(a,"type",new L.hC()))
if(z==="dot")y=this.b.co(this.a.a,H.d(a,"$isK"))
else if(z==="brick")y=this.b.cn(this.a.a,H.d(a,"$isK"))
else if(z==="barrier")y=this.b.cm(this.a.a,H.d(a,"$isK"))
else if(z==="doubleup")y=this.b.cp(this.a.a,H.d(a,"$isK"))
else if(z==="drill")y=this.b.cq(this.a.a,H.d(a,"$isK"))
else y=z==="slowdown"?this.b.ct(this.a.a,H.d(a,"$isK")):null
if(y!=null){x=this.b.a
w=x.ch
x=x.x
if(typeof x!=="number")return H.j(x)
y.d=w*x/40
C.b.p(this.c,y)}++this.a.a}},hC:{"^":"a:38;",
$0:function(){return""}},hi:{"^":"a:0;",
$0:function(){return 100}},hj:{"^":"a:0;",
$0:function(){return 100}},hk:{"^":"a:0;",
$0:function(){return 100}},hl:{"^":"a:0;",
$0:function(){return 100}},hm:{"^":"a:0;",
$0:function(){return 100}},ht:{"^":"a:0;",
$0:function(){return 0}},hu:{"^":"a:0;",
$0:function(){return 0}},hv:{"^":"a:0;",
$0:function(){return 1}},hq:{"^":"a:0;",
$0:function(){return 0}},hr:{"^":"a:0;",
$0:function(){return 0}},hs:{"^":"a:0;",
$0:function(){return 1}},hn:{"^":"a:0;",
$0:function(){return 0}},ho:{"^":"a:0;",
$0:function(){return 0}},hp:{"^":"a:0;",
$0:function(){return 0}},hw:{"^":"a:0;",
$0:function(){return 0}},hx:{"^":"a:0;",
$0:function(){return 0}},hA:{"^":"a:0;",
$0:function(){return 0}},hB:{"^":"a:0;",
$0:function(){return 0}},hy:{"^":"a:0;",
$0:function(){return 0}},hz:{"^":"a:0;",
$0:function(){return 0}}}],["","",,D,{"^":"",bV:{"^":"v;0a,0b,c,d,0e,f,0r,0x",
i:function(a){return"barrier"},
H:function(a){}}}],["","",,X,{"^":"",bp:{"^":"v;0y,0a,0b,c,d,0e,f,0r,0x",
i:function(a){return"brick"},
H:function(a){if(a instanceof N.bt)this.y=0}}}],["","",,B,{"^":"",
f6:function(a,b){var z,y,x,w,v
z=a.f
y=b.f
x=b.x
if(typeof x!=="number")return H.j(x)
if(z<=y+x){x=a.e
w=b.e
v=b.r
if(typeof w!=="number")return w.A()
if(typeof v!=="number")return H.j(v)
if(typeof x!=="number")return x.bP()
if(x<=w+v){v=a.x
if(typeof v!=="number")return H.j(v)
if(!(z+v<y)){z=a.r
if(typeof z!=="number")return H.j(z)
w=x+z<w
z=w}else z=!0
z=!z}else z=!1}else z=!1
if(z)return!0
return!1},
f4:function(a,b){var z,y,x,w,v,u
z=a.r
if(typeof z!=="number")return z.ae()
y=z/2
z=b.r
if(typeof z!=="number")return z.ae()
x=z/2
z=a.e
if(typeof z!=="number")return z.A()
w=a.f
v=b.e
if(typeof v!=="number")return v.A()
u=b.f
if(y+x>=Math.sqrt(Math.pow(z+y-(v+x),2)+Math.pow(w+y-(u+x),2)))return!0
return!1},
f5:function(a,b){var z,y,x,w,v,u
if(!B.f6(a,b))return!1
z=b.r
if(typeof z!=="number")return z.ae()
y=z/2
z=b.e
if(typeof z!=="number")return z.A()
x=z+y
w=b.f+y
z=a.e
if(typeof z!=="number")return H.j(z)
if(x<z&&w<a.f)if(y<Math.sqrt(Math.pow(x-z,2)+Math.pow(w-a.f,2)))return!1
z=a.e
v=a.r
if(typeof z!=="number")return z.A()
if(typeof v!=="number")return H.j(v)
v=z+v
if(x>v&&w<a.f)if(y<Math.sqrt(Math.pow(x-v,2)+Math.pow(w-a.f,2)))return!1
z=a.e
if(typeof z!=="number")return H.j(z)
if(x<z){v=a.f
u=a.x
if(typeof u!=="number")return H.j(u)
u=w>v+u
v=u}else v=!1
if(v){z=Math.pow(x-z,2)
v=a.f
u=a.x
if(typeof u!=="number")return H.j(u)
if(y<Math.sqrt(z+Math.pow(w-(v+u),2)))return!1}z=a.e
v=a.r
if(typeof z!=="number")return z.A()
if(typeof v!=="number")return H.j(v)
v=z+v
if(x>v){z=a.f
u=a.x
if(typeof u!=="number")return H.j(u)
u=w>z+u
z=u}else z=!1
if(z){z=Math.pow(x-v,2)
v=a.f
u=a.x
if(typeof u!=="number")return H.j(u)
if(y<Math.sqrt(z+Math.pow(w-(v+u),2)))return!1}return!0}}],["","",,K,{"^":"",a_:{"^":"b;a,b"}}],["","",,F,{"^":"",bs:{"^":"v;0y,0a,0b,c,d,0e,f,0r,0x",
i:function(a){return"dot"},
H:function(a){}}}],["","",,Z,{"^":"",da:{"^":"bE;y,0a,0b,c,d,0e,f,0r,0x",
H:function(a){},
i:function(a){return"doubleup"}}}],["","",,N,{"^":"",bt:{"^":"v;0y,z,Q,0ch,0cx,cy,db,dx,dy,0a,0b,c,d,0e,f,0r,0x",
c1:function(a){var z,y,x,w,v,u
this.b=0
this.d=0
this.y=a.e
this.a=a
this.x=C.d.u(a.Q*0.05)
z=C.d.u(this.a.Q*0.05)
this.r=z
this.e=this.a.Q/2-z
this.f=this.aE()
z=this.x
if(typeof z!=="number")return z.at()
this.ch=z*0.5
z=this.a
y=z.ch
z=z.x
if(typeof z!=="number")return H.j(z)
this.cx=y*z/40/(0.96*z+1.62)
z=this.z
x=0
while(!0){y=this.a
w=y.f
if(typeof w!=="number")return w.at()
if(!(x<=w*40))break
w=this.e
v=this.f
u=this.ch
if(typeof u!=="number")return H.j(u)
y=y.x
if(typeof y!=="number")return H.j(y)
C.b.p(z,new K.a_(w,v+x*u*y));++x}this.bj()},
S:function(a){var z=0,y=P.F(null),x,w=this,v,u,t,s
var $async$S=P.G(function(b,c){if(b===1)return P.C(c,y)
while(true)switch(z){case 0:v=w.e
u=w.c
if(typeof v!=="number"){x=v.A()
z=1
break}if(v+u<0){u=v*-1
w.c=u}t=w.r
if(typeof t!=="number"){x=H.j(t)
z=1
break}s=w.a.Q
if(v+u+t>s)w.c=s-v-t
w.bT(0)
v=w.z
if(0>=v.length){x=H.A(v,-1)
z=1
break}v.pop()
C.b.q(v,new N.fE(w))
C.b.a1(v,0,new K.a_(w.e,w.f))
w.cM()
w.cN()
case 1:return P.D(x,y)}})
return P.E($async$S,y)},
cN:function(){if(this.aE()<this.f){C.b.q(this.z,new N.fn());--this.f
return}if(this.aE()>this.f){C.b.q(this.z,new N.fo());++this.f
return}},
bj:function(){var z,y,x,w,v,u
z=this.Q
while(!0){y=z.length
x=this.y
if(typeof x!=="number")return H.j(x)
if(!(y>=x&&y>0))break
if(0>=y)return H.A(z,-1)
z.pop()}while(!0){y=z.length+1
x=this.y
if(typeof x!=="number")return H.j(x)
if(!(y<x))break
x=this.e
w=this.f
v=this.a
u=new F.au(0,0,0)
u.b=-1*y
u.e=x
u.f=w
w=v.Q*0.05
u.x=C.d.u(w)
u.r=C.d.u(w)
u.a=v
C.b.p(z,u)}},
cM:function(){var z,y,x,w,v,u,t,s
z={}
y=this.z
z.a=C.b.gam(y)
for(x=this.Q,w=H.i(y,0),v=0;v<x.length;++v){u=H.iE(y,v,null,w).d3(0,new N.fm(z,this))
t=x.length
if(v>=t)return H.A(x,v)
s=x[v]
s.e=u.a
if(v>=t)return H.A(x,v)
s.f=u.b
z.a=u}},
bs:function(a){var z
if(this.dy){if(typeof a!=="number")return a.as()
z=a>0}else z=!1
if(z){if(typeof a!=="number")return a.at()
a*=2}if(this.dx){if(typeof a!=="number")return a.Z()
z=a<0}else z=!1
if(z)a=0
z=this.y
if(typeof z!=="number")return z.A()
if(typeof a!=="number")return H.j(a)
this.y=z+a
this.bj()},
i:function(a){return"dozer"},
H:function(a){var z=0,y=P.F(null),x,w=this,v,u,t,s
var $async$H=P.G(function(b,c){if(b===1)return P.C(c,y)
while(true)switch(z){case 0:v=J.u(a)
if(!!v.$isbp){v=a.y
if(typeof v!=="number"){x=H.j(v)
z=1
break}w.bs(-1*v)
z=1
break}if(!!v.$isbs){w.bs(a.y)
z=1
break}if(!!v.$isbV){v=w.c
if(v<0){u=a.e
t=a.r
if(typeof u!=="number"){x=u.A()
z=1
break}if(typeof t!=="number"){x=H.j(t)
z=1
break}w.e=u+t-v}else if(v>0){u=a.e
t=w.r
if(typeof u!=="number"){x=u.aw()
z=1
break}if(typeof t!=="number"){x=H.j(t)
z=1
break}w.e=u-t-v}z=1
break}if(!!v.$isda){v=w.db
if(v.length>0)C.b.gam(v).N(new N.fv(w,a),null)
else{s=P.aO(P.av(0,0,0,a.y,0,0),new N.fw(),null)
s.N(new N.fx(w),null)
C.b.a1(v,0,s)}w.dy=!0
z=1
break}if(!!v.$isdb){v=w.cy
if(v.length>0)C.b.gam(v).N(new N.fy(w,a),null)
else{s=P.aO(P.av(0,0,0,a.y,0,0),new N.fz(),null)
s.N(new N.fA(w),null)
C.b.a1(v,0,s)}w.dx=!0
z=1
break}if(!!v.$isdA){v=w.a.cx
if(v.length>0)C.b.gam(v).N(new N.fB(w,a),null)
else{s=P.aO(P.av(0,0,0,a.y,0,0),new N.fC(),null)
s.N(new N.fD(w),null)
C.b.a1(w.a.cx,0,s)}w.a.cy=!0
z=1
break}case 1:return P.D(x,y)}})
return P.E($async$H,y)},
aE:function(){var z,y
z=this.a.ch
y=this.y
if(typeof y!=="number")return y.at()
return Math.max(z*(1-y*1.5/100)-10,z*0.7)},
ar:function(){return 0},
m:{
fl:function(a){var z=[[P.H,,]]
z=new N.bt(H.y([],[K.a_]),H.y([],[F.au]),H.y([],z),H.y([],z),!1,!1,0,0,0)
z.c1(a)
return z}}},fE:{"^":"a:8;a",
$1:function(a){var z,y
H.d(a,"$isa_")
z=a.b
y=this.a.cx
if(typeof y!=="number")return H.j(y)
y=z+y
a.b=y
return y}},fn:{"^":"a:8;",
$1:function(a){return--H.d(a,"$isa_").b}},fo:{"^":"a:8;",
$1:function(a){return++H.d(a,"$isa_").b}},fm:{"^":"a:41;a,b",
$1:function(a){var z,y,x
H.d(a,"$isa_")
z=a.b
y=this.a
x=y.a.b
if(z>x){z=Math.pow(x-z,2)
y=y.a.a
x=a.a
if(typeof y!=="number")return y.aw()
if(typeof x!=="number")return H.j(x)
x=Math.sqrt(z+Math.pow(y-x,2))
y=this.b.ch
if(typeof y!=="number")return H.j(y)
y=x>=y
z=y}else z=!1
return z}},fv:{"^":"a:2;a,b",
$1:function(a){var z,y
z=this.a
z.dy=!0
y=P.aO(P.av(0,0,0,this.b.y,0,0),new N.ft(),null)
y.N(new N.fu(z),null)
z=z.db
C.b.a1(z,0,y)
if(0>=z.length)return H.A(z,-1)
z.pop()}},ft:{"^":"a:5;",
$0:function(){return!0}},fu:{"^":"a:2;a",
$1:function(a){this.a.dy=!1}},fw:{"^":"a:5;",
$0:function(){return!0}},fx:{"^":"a:2;a",
$1:function(a){this.a.dy=!1}},fy:{"^":"a:2;a,b",
$1:function(a){var z,y
z=this.a
z.dx=!0
y=P.aO(P.av(0,0,0,this.b.y,0,0),new N.fr(),null)
y.N(new N.fs(z),null)
z=z.cy
C.b.a1(z,0,y)
if(0>=z.length)return H.A(z,-1)
z.pop()}},fr:{"^":"a:5;",
$0:function(){return!0}},fs:{"^":"a:2;a",
$1:function(a){this.a.dx=!1}},fz:{"^":"a:5;",
$0:function(){return!0}},fA:{"^":"a:2;a",
$1:function(a){this.a.dx=!1}},fB:{"^":"a:2;a,b",
$1:function(a){var z,y
z=this.a
z.a.cy=!0
y=P.aO(P.av(0,0,0,this.b.y,0,0),new N.fp(),null)
y.N(new N.fq(z),null)
C.b.a1(z.a.cx,0,y)
z=z.a.cx
if(0>=z.length)return H.A(z,-1)
z.pop()}},fp:{"^":"a:5;",
$0:function(){return!0}},fq:{"^":"a:2;a",
$1:function(a){this.a.a.cy=!1}},fC:{"^":"a:5;",
$0:function(){return!0}},fD:{"^":"a:2;a",
$1:function(a){this.a.a.cy=!1}}}],["","",,F,{"^":"",au:{"^":"v;0a,0b,c,d,0e,f,0r,0x",
i:function(a){return"dozertail"},
H:function(a){},
ar:function(){return 0}}}],["","",,G,{"^":"",db:{"^":"bE;y,0a,0b,c,d,0e,f,0r,0x",
H:function(a){},
i:function(a){return"drill"}}}],["","",,O,{"^":"",v:{"^":"b;",
S:["bT",function(a){var z,y
z=this.e
y=this.c
if(typeof z!=="number")return z.A()
this.e=z+y
this.f=this.f+this.ar()
return}],
ar:function(){if(this.a.cy)return this.d*0.5
return this.d}}}],["","",,Q,{"^":"",dk:{"^":"b;0a,b,0c,d,e,f,0r,0x,y,0z,Q,ch,cx,cy",
sds:function(a){this.z=H.V(a,"$ist",[O.v],"$ast")},
c2:function(a,b,c,d,e,f,g){var z=this.d
z.toString
this.c=z
this.x=d
z=N.fl(this)
this.a=z
this.y.n(0,z.b,new Q.hQ(this))},
ag:function(){var z=this.d
if(typeof z!=="number")return H.j(z)
return C.o.u(1e5/z*this.c)},
S:function(a){var z=0,y=P.F(null),x=this
var $async$S=P.G(function(b,c){if(b===1)return P.C(c,y)
while(true)switch(z){case 0:x.y.q(0,new Q.hU())
x.aO()
x.aU()
x.aY()
x.aR()
x.a.S(0)
return P.D(null,y)}})
return P.E($async$S,y)},
aR:function(){var z=0,y=P.F(null),x=this
var $async$aR=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:P.bB(x.y,P.w,O.v).q(0,new Q.hP(x))
return P.D(null,y)}})
return P.E($async$aR,y)},
aO:function(){var z=0,y=P.F(null),x,w=this,v,u,t,s,r
var $async$aO=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:v={}
u=w.x
if(typeof u!=="number"){x=H.j(u)
z=1
break}t=w.d
s=w.c
if(typeof t!=="number"){x=t.aw()
z=1
break}r=P.ay(w.z,!0,O.v)
v.a=null
v.b=null
C.b.q(r,new Q.hO(v,w,w.ch*u*(t-s)/1000))
case 1:return P.D(x,y)}})
return P.E($async$aO,y)},
aU:function(){var z=0,y=P.F(null),x=this
var $async$aU=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:P.bB(x.y,P.w,O.v).q(0,new Q.hR(x))
return P.D(null,y)}})
return P.E($async$aU,y)},
Y:function(a){var z=this.x
if(typeof z!=="number")return H.j(z)
if(typeof a!=="number")return H.j(a)
return this.ch*z*a/-1000},
aY:function(){var z=0,y=P.F(null),x=this,w,v,u
var $async$aY=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:C.b.q(x.a.Q,new Q.hT(x))
for(w=x.a.Q.length+1,v=x.y;u=-1*w,v.G(0,u);++w)v.R(0,u)
return P.D(null,y)}})
return P.E($async$aY,y)},
m:{
hc:function(a,b,c,d,e,f,g){var z=new Q.dk(e,a,b,c,new H.b5(0,0,[P.w,O.v]),g,f,H.y([],[[P.H,,]]),!1)
z.c2(a,b,c,d,e,f,g)
return z}}},hQ:{"^":"a:43;a",
$0:function(){return this.a.a}},hU:{"^":"a:44;",
$2:function(a,b){H.M(a)
return H.d(b,"$isv").S(0)}},hP:{"^":"a:17;a",
$2:function(a,b){var z,y
H.M(a)
H.d(b,"$isv")
z=J.u(b)
y=!!z.$isbp
if(y||!!z.$isbV){z=this.a
if(B.f5(b,z.a)){z.a.H(b)
b.H(z.a)
if(y)z.y.R(0,a)}}else if(!!z.$isbs||!!z.$isbE){z=this.a
if(B.f4(b,z.a)){z.a.H(b)
b.H(z.a)
z.y.R(0,a)}}}},hO:{"^":"a:46;a,b,c",
$1:function(a){var z,y,x,w,v,u,t
H.d(a,"$isv")
z=this.a
y=z.a
if(y!=null){x=a.f
if(x<y){w=a.x
if(typeof w!=="number")return H.j(w)
v=z.b
if(typeof v!=="number")return H.j(v)
v=x+w<y+v
y=v}else y=!1}else y=!1
if(y)return
u=a.f
z.a=u
t=a.x
z.b=t
if(typeof t!=="number")return H.j(t)
z=this.c
if(u+t+z>=0){a.f=u+C.d.u(z)
z=this.b
z.y.n(0,a.b,new Q.hN(a))
z=z.z;(z&&C.b).R(z,a)}}},hN:{"^":"a:47;a",
$0:function(){return this.a}},hR:{"^":"a:17;a",
$2:function(a,b){var z
H.M(a)
z=this.a
if(z.ch<H.d(b,"$isv").f)z.y.R(0,a)}},hT:{"^":"a:48;a",
$1:function(a){H.d(a,"$isau")
this.a.y.n(0,a.b,new Q.hS(a))}},hS:{"^":"a:49;a",
$0:function(){return this.a}}}],["","",,B,{"^":"",bE:{"^":"v;"}}],["","",,A,{"^":"",dA:{"^":"bE;y,0a,0b,c,d,0e,f,0r,0x",
H:function(a){},
i:function(a){return"slowdown"}}}],["","",,T,{"^":"",hG:{"^":"b;0a,0b,0c,d,e,f",
K:function(){var z=0,y=P.F(null),x=this,w,v
var $async$K=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:x.aM()
w=x.e
if(w!==x.a.a.dx){x.e=!w
x.aL()}w=x.f
if(w!==x.a.a.dy){x.f=!w
x.aK()}v=P.bB(x.a.y,P.w,O.v)
P.bB(x.d,P.h,W.o).q(0,new T.hL(x,v))
v.q(0,new T.hM(x))
return P.D(null,y)}})
return P.E($async$K,y)},
aK:function(){var z=0,y=P.F(null),x=this
var $async$aK=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:x.d.q(0,new T.hI())
return P.D(null,y)}})
return P.E($async$aK,y)},
aL:function(){var z=0,y=P.F(null),x=this
var $async$aL=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:x.d.q(0,new T.hJ())
return P.D(null,y)}})
return P.E($async$aL,y)},
cr:function(a){var z,y,x
z=J.u(a)
if(z.i(a)==="dozer"){z=document
y=z.createElement("div")
C.a.j(y,"class","entity dozer head")
C.a.j(y,"id","e"+J.B(a.b))
x=z.createElement("div")
C.a.j(x,"class","eye left-eye")
C.a.h(y,x)
z=z.createElement("div")
C.a.j(z,"class","eye right-eye")
C.a.h(y,z)
return y}else if(z.i(a)==="dozertail"){z=document.createElement("div")
C.a.j(z,"class","entity dozer "+(this.e?"has-drill":""))
C.a.j(z,"id","e"+J.B(a.b))
return z}else if(z.i(a)==="dot"){z=document
y=z.createElement("div")
C.a.j(y,"class","entity dot "+(this.f?"has-doubleup":""))
C.a.j(y,"id","e"+J.B(a.b))
C.a.h(y,z.createTextNode(J.B(H.cK(a,"$isbs").y)))
return y}else if(z.i(a)==="brick"){z=document
y=z.createElement("div")
H.cK(a,"$isbp")
C.a.j(y,"class","entity brick "+T.hH(a.y))
C.a.j(y,"id","e"+J.B(a.b))
C.a.h(y,z.createTextNode(J.B(a.y)))
return y}else if(z.i(a)==="barrier"){z=document.createElement("div")
C.a.j(z,"class","entity barrier")
C.a.j(z,"id","e"+J.B(a.b))
return z}else if(z.i(a)==="doubleup"||z.i(a)==="drill"||z.i(a)==="slowdown"){y=document.createElement("div")
C.a.j(y,"class","entity powerup "+z.i(a))
C.a.j(y,"id","e"+J.B(a.b))
return y}return document.createElement("div")},
aM:function(){var z=0,y=P.F(null),x=this,w
var $async$aM=P.G(function(a,b){if(a===1)return P.C(b,y)
while(true)switch(z){case 0:w=x.c
J.bT(J.eF(new W.cr(w,w.children).l(0,1)).l(0,1),"value",J.B(x.a.a.y))
w=x.c
J.cT(new W.cr(w,w.children).l(0,2),C.o.bI(x.a.c/1000,2))
return P.D(null,y)}})
return P.E($async$aM,y)},
m:{
bA:function(a,b){var z=0,y=P.F(null)
var $async$bA=P.G(function(c,d){if(c===1)return P.C(d,y)
while(true)switch(z){case 0:a.style.cssText="top:"+H.f(b.f)+"px;"+("left:"+H.f(b.e)+"px;")+("width:"+H.f(b.r)+"px;")+("height:"+H.f(b.x)+"px;")
return P.D(null,y)}})
return P.E($async$bA,y)},
hH:function(a){if(typeof a!=="number")return a.Z()
if(a<4)return"c1"
else if(a<7)return"c2"
else if(a<11)return"c3"
else if(a<16)return"c4"
else return"c5"}}},hL:{"^":"a:9;a,b",
$2:function(a,b){return this.bN(H.m(a),H.d(b,"$iso"))},
bN:function(a,b){var z=0,y=P.F(P.k),x=this,w
var $async$$2=P.G(function(c,d){if(c===1)return P.C(d,y)
while(true)switch(z){case 0:a=P.bf(J.eL(b.id,1),null,null)
w=x.b
if(w.G(0,a))T.bA(b,w.l(0,a))
else{J.bS(b)
x.a.d.R(0,b.id)}w.R(0,a)
return P.D(null,y)}})
return P.E($async$$2,y)}},hM:{"^":"a:51;a",
$2:function(a,b){return this.bM(H.M(a),H.d(b,"$isv"))},
bM:function(a,b){var z=0,y=P.F(P.k),x=this,w,v
var $async$$2=P.G(function(c,d){if(c===1)return P.C(d,y)
while(true)switch(z){case 0:w=x.a
v=w.cr(b)
C.a.h(w.b,v)
w.d.n(0,"e"+J.B(a),new T.hK(v))
T.bA(v,b)
return P.D(null,y)}})
return P.E($async$$2,y)}},hK:{"^":"a:52;a",
$0:function(){return this.a}},hI:{"^":"a:9;",
$2:function(a,b){return this.bK(H.m(a),H.d(b,"$iso"))},
bK:function(a,b){var z=0,y=P.F(P.k),x
var $async$$2=P.G(function(c,d){if(c===1)return P.C(d,y)
while(true)switch(z){case 0:x=J.r(b)
if(x.gac(b).v(0,"dot"))x.gac(b).aW(0,"has-doubleup")
return P.D(null,y)}})
return P.E($async$$2,y)}},hJ:{"^":"a:9;",
$2:function(a,b){return this.bL(H.m(a),H.d(b,"$iso"))},
bL:function(a,b){var z=0,y=P.F(P.k),x
var $async$$2=P.G(function(c,d){if(c===1)return P.C(d,y)
while(true)switch(z){case 0:x=J.r(b)
if(x.gac(b).v(0,"dozer"))x.gac(b).aW(0,"has-drill")
return P.D(null,y)}})
return P.E($async$$2,y)}}}],["","",,N,{"^":"",ak:{"^":"b;0a",
K:function(){var z=document
J.cT(C.h.J(z,"body"),"<div id='menu'></div>")
J.eH(C.h.J(z,"#menu"),"afterbegin",this.a)},
U:function(){var z=document.createElement("h1")
C.l.a5(z,"Dozer")
C.l.j(z,"id","dozer-logo")
return z},
cU:function(a,b){var z,y,x,w,v,u,t,s
z=document
y=z.createElement("div")
C.a.j(y,"class","message")
C.a.h(y,this.U())
C.a.h(y,z.createElement("hr"))
x=z.createElement("div")
C.a.j(x,"class","choose-level-wrapper")
for(w=0;w<a;w=u){v=z.createElement("button")
u=w+1
C.c.j(v,"value",C.f.i(u))
if(typeof b!=="number")return H.j(b)
C.c.j(v,"class","choose-level "+(w<b?"reached":""))
C.c.j(v,"id","level-"+u)
C.c.h(v,z.createTextNode(C.f.i(u)))
C.a.h(x,v)}C.a.h(y,x)
t=z.createElement("button")
C.c.j(t,"id","button_to_menu")
C.c.j(t,"class","lower-bottom-button")
C.c.h(t,z.createTextNode("Return"))
s=z.createElement("div")
C.a.h(s,y)
y=z.createElement("div")
C.a.j(y,"class","button-box")
C.a.j(y,"style","height: 10%")
C.c.j(t,"style","height: 100%")
C.a.h(y,t)
C.a.h(s,y)
this.a=s
return this}}}],["","",,F,{"^":"",
eu:function(){var z,y,x,w,v,u,t,s,r,q,p
z=window.localStorage
y=new M.eO(z,1,1,500,!1)
if((z&&C.j).F(z,"reachedLevel")!=null){z=P.bf(C.j.F(z,"reachedLevel"),null,null)
y.c=z}else z=1
y.b=z
x=P.dx("(iPad)|(iPhone)|(iPod)|(android)|(webOS)|(ipad)|(iphone)|(Android)",!0,!1)
z=window.navigator.userAgent
if(typeof z!=="string")H.S(H.aH(z))
if(!x.b.test(z)){z=new N.ak()
w=document
v=w.createElement("div")
C.a.j(v,"class","message")
C.a.h(v,z.U())
C.a.h(v,w.createElement("hr"))
u=w.createElement("p")
C.e.h(u,w.createTextNode("Oh No! On this device motion control is not available."))
C.a.h(v,u)
t=W.c4(null,null,null)
C.v.j(t,"src","resources/qr-code.jpg")
C.a.h(v,t)
s=w.createElement("p")
C.e.h(s,w.createTextNode("Scan the QR-Code or play with your arrow keys."))
C.a.h(v,s)
C.a.h(v,w.createElement("hr"))
r=w.createElement("button")
C.c.j(r,"id","button_to_menu")
C.c.j(r,"class","lower-bottom-button")
C.c.h(r,w.createTextNode("Let me play anyway"))
q=w.createElement("div")
C.a.h(q,v)
v=w.createElement("div")
C.a.j(v,"class","button-box")
C.a.j(v,"style","height: 10%")
C.c.j(r,"style","height: 100%")
C.a.h(v,r)
C.a.h(q,v)
z.a=q
z.K()
y.ap()}else{z=window.innerHeight
w=window.screen.height
if(typeof z!=="number")return z.ae()
if(typeof w!=="number")return H.j(w)
if(z/w<0.92){z=new N.ak()
w=document
v=w.createElement("div")
C.a.j(v,"class","message")
C.a.h(v,z.U())
C.a.h(v,w.createElement("hr"))
u=w.createElement("p")
C.e.h(u,w.createTextNode("Welcome to Dozer - Have fun!"))
C.a.h(v,u)
C.a.h(v,w.createElement("hr"))
p=w.createElement("p")
C.e.j(p,"class","tap-me")
C.e.h(p,w.createTextNode("Tap To Continue"))
C.a.h(v,p)
q=w.createElement("div")
C.a.j(q,"id","button_to_menu")
C.a.h(q,v)
z.a=q
z.K()
y.dg()
y.e=!0}else{y.a_()
y.e=!0}}}},1]]
setupProgram(dart,0,0)
J.u=function(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.dh.prototype
return J.dg.prototype}if(typeof a=="string")return J.bx.prototype
if(a==null)return J.h4.prototype
if(typeof a=="boolean")return J.h2.prototype
if(a.constructor==Array)return J.b3.prototype
if(typeof a!="object"){if(typeof a=="function")return J.b4.prototype
return a}if(a instanceof P.b)return a
return J.bN(a)}
J.bd=function(a){if(typeof a=="string")return J.bx.prototype
if(a==null)return a
if(a.constructor==Array)return J.b3.prototype
if(typeof a!="object"){if(typeof a=="function")return J.b4.prototype
return a}if(a instanceof P.b)return a
return J.bN(a)}
J.be=function(a){if(a==null)return a
if(a.constructor==Array)return J.b3.prototype
if(typeof a!="object"){if(typeof a=="function")return J.b4.prototype
return a}if(a instanceof P.b)return a
return J.bN(a)}
J.eq=function(a){if(typeof a=="number")return J.bw.prototype
if(a==null)return a
if(!(a instanceof P.b))return J.bH.prototype
return a}
J.cH=function(a){if(typeof a=="string")return J.bx.prototype
if(a==null)return a
if(!(a instanceof P.b))return J.bH.prototype
return a}
J.r=function(a){if(a==null)return a
if(typeof a!="object"){if(typeof a=="function")return J.b4.prototype
return a}if(a instanceof P.b)return a
return J.bN(a)}
J.bg=function(a,b){if(a==null)return b==null
if(typeof a!="object")return b!=null&&a===b
return J.u(a).T(a,b)}
J.ez=function(a,b){if(typeof a=="number"&&typeof b=="number")return a<b
return J.eq(a).Z(a,b)}
J.cP=function(a,b){if(typeof b==="number")if(a.constructor==Array||typeof a=="string"||H.ko(a,a[init.dispatchPropertyName]))if(b>>>0===b&&b<a.length)return a[b]
return J.bd(a).l(a,b)}
J.eA=function(a,b,c,d){return J.r(a).c8(a,b,c,d)}
J.eB=function(a,b){return J.r(a).bf(a,b)}
J.bh=function(a,b){return J.r(a).cC(a,b)}
J.eC=function(a,b){return J.r(a).h(a,b)}
J.eD=function(a,b){return J.bd(a).v(a,b)}
J.bR=function(a,b,c){return J.bd(a).cW(a,b,c)}
J.bi=function(a,b){return J.be(a).C(a,b)}
J.cQ=function(a){return J.eq(a).u(a)}
J.cR=function(a,b){return J.be(a).q(a,b)}
J.eE=function(a){return J.r(a).gcR(a)}
J.eF=function(a){return J.r(a).gbt(a)}
J.bj=function(a){return J.u(a).gE(a)}
J.at=function(a){return J.be(a).gB(a)}
J.a1=function(a){return J.bd(a).gk(a)}
J.a2=function(a){return J.r(a).gbD(a)}
J.eG=function(a){return J.r(a).gdr(a)}
J.bk=function(a,b){return J.r(a).a2(a,b)}
J.eH=function(a,b,c){return J.r(a).bx(a,b,c)}
J.cS=function(a,b,c){return J.r(a).by(a,b,c)}
J.eI=function(a,b,c){return J.be(a).bA(a,b,c)}
J.eJ=function(a,b){return J.u(a).aT(a,b)}
J.eK=function(a,b,c){return J.r(a).n(a,b,c)}
J.bS=function(a){return J.be(a).dt(a)}
J.bT=function(a,b,c){return J.r(a).j(a,b,c)}
J.cT=function(a,b){return J.r(a).a5(a,b)}
J.eL=function(a,b){return J.cH(a).b1(a,b)}
J.eM=function(a){return J.cH(a).dC(a)}
J.B=function(a){return J.u(a).i(a)}
J.cU=function(a){return J.cH(a).dD(a)}
I.ae=function(a){a.immutable$list=Array
a.fixed$length=Array
return a}
var $=I.p
C.n=W.bn.prototype
C.c=W.eZ.prototype
C.u=W.fd.prototype
C.a=W.br.prototype
C.E=W.fk.prototype
C.G=W.fP.prototype
C.l=W.fQ.prototype
C.h=W.fS.prototype
C.H=W.aP.prototype
C.v=W.fY.prototype
C.I=J.x.prototype
C.b=J.b3.prototype
C.o=J.dg.prototype
C.f=J.dh.prototype
C.d=J.bw.prototype
C.k=J.bx.prototype
C.P=J.b4.prototype
C.A=W.i8.prototype
C.e=W.ic.prototype
C.B=J.id.prototype
C.r=W.ch.prototype
C.C=W.is.prototype
C.m=W.iw.prototype
C.j=W.dC.prototype
C.D=W.iF.prototype
C.t=J.bH.prototype
C.X=W.cp.prototype
C.i=new P.js()
C.F=new P.b2(0)
C.J=function(hooks) {
  if (typeof dartExperimentalFixupGetTag != "function") return hooks;
  hooks.getTag = dartExperimentalFixupGetTag(hooks.getTag);
}
C.K=function(hooks) {
  var userAgent = typeof navigator == "object" ? navigator.userAgent : "";
  if (userAgent.indexOf("Firefox") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "GeoGeolocation": "Geolocation",
    "Location": "!Location",
    "WorkerMessageEvent": "MessageEvent",
    "XMLDocument": "!Document"};
  function getTagFirefox(o) {
    var tag = getTag(o);
    return quickMap[tag] || tag;
  }
  hooks.getTag = getTagFirefox;
}
C.w=function(hooks) { return hooks; }

C.L=function(getTagFallback) {
  return function(hooks) {
    if (typeof navigator != "object") return hooks;
    var ua = navigator.userAgent;
    if (ua.indexOf("DumpRenderTree") >= 0) return hooks;
    if (ua.indexOf("Chrome") >= 0) {
      function confirm(p) {
        return typeof window == "object" && window[p] && window[p].name == p;
      }
      if (confirm("Window") && confirm("HTMLElement")) return hooks;
    }
    hooks.getTag = getTagFallback;
  };
}
C.M=function() {
  var toStringFunction = Object.prototype.toString;
  function getTag(o) {
    var s = toStringFunction.call(o);
    return s.substring(8, s.length - 1);
  }
  function getUnknownTag(object, tag) {
    if (/^HTML[A-Z].*Element$/.test(tag)) {
      var name = toStringFunction.call(object);
      if (name == "[object Object]") return null;
      return "HTMLElement";
    }
  }
  function getUnknownTagGenericBrowser(object, tag) {
    if (self.HTMLElement && object instanceof HTMLElement) return "HTMLElement";
    return getUnknownTag(object, tag);
  }
  function prototypeForTag(tag) {
    if (typeof window == "undefined") return null;
    if (typeof window[tag] == "undefined") return null;
    var constructor = window[tag];
    if (typeof constructor != "function") return null;
    return constructor.prototype;
  }
  function discriminator(tag) { return null; }
  var isBrowser = typeof navigator == "object";
  return {
    getTag: getTag,
    getUnknownTag: isBrowser ? getUnknownTagGenericBrowser : getUnknownTag,
    prototypeForTag: prototypeForTag,
    discriminator: discriminator };
}
C.N=function(hooks) {
  var userAgent = typeof navigator == "object" ? navigator.userAgent : "";
  if (userAgent.indexOf("Trident/") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "HTMLDDElement": "HTMLElement",
    "HTMLDTElement": "HTMLElement",
    "HTMLPhraseElement": "HTMLElement",
    "Position": "Geoposition"
  };
  function getTagIE(o) {
    var tag = getTag(o);
    var newTag = quickMap[tag];
    if (newTag) return newTag;
    if (tag == "Object") {
      if (window.DataView && (o instanceof window.DataView)) return "DataView";
    }
    return tag;
  }
  function prototypeForTagIE(tag) {
    var constructor = window[tag];
    if (constructor == null) return null;
    return constructor.prototype;
  }
  hooks.getTag = getTagIE;
  hooks.prototypeForTag = prototypeForTagIE;
}
C.O=function(hooks) {
  var getTag = hooks.getTag;
  var prototypeForTag = hooks.prototypeForTag;
  function getTagFixed(o) {
    var tag = getTag(o);
    if (tag == "Document") {
      if (!!o.xmlVersion) return "!Document";
      return "!HTMLDocument";
    }
    return tag;
  }
  function prototypeForTagFixed(tag) {
    if (tag == "Document") return null;
    return prototypeForTag(tag);
  }
  hooks.getTag = getTagFixed;
  hooks.prototypeForTag = prototypeForTagFixed;
}
C.x=function getTagFallback(o) {
  var s = Object.prototype.toString.call(o);
  return s.substring(8, s.length - 1);
}
C.Q=new P.ha(null,null)
C.R=new P.hb(null)
C.S=H.y(I.ae(["*::class","*::dir","*::draggable","*::hidden","*::id","*::inert","*::itemprop","*::itemref","*::itemscope","*::lang","*::spellcheck","*::title","*::translate","A::accesskey","A::coords","A::hreflang","A::name","A::shape","A::tabindex","A::target","A::type","AREA::accesskey","AREA::alt","AREA::coords","AREA::nohref","AREA::shape","AREA::tabindex","AREA::target","AUDIO::controls","AUDIO::loop","AUDIO::mediagroup","AUDIO::muted","AUDIO::preload","BDO::dir","BODY::alink","BODY::bgcolor","BODY::link","BODY::text","BODY::vlink","BR::clear","BUTTON::accesskey","BUTTON::disabled","BUTTON::name","BUTTON::tabindex","BUTTON::type","BUTTON::value","CANVAS::height","CANVAS::width","CAPTION::align","COL::align","COL::char","COL::charoff","COL::span","COL::valign","COL::width","COLGROUP::align","COLGROUP::char","COLGROUP::charoff","COLGROUP::span","COLGROUP::valign","COLGROUP::width","COMMAND::checked","COMMAND::command","COMMAND::disabled","COMMAND::label","COMMAND::radiogroup","COMMAND::type","DATA::value","DEL::datetime","DETAILS::open","DIR::compact","DIV::align","DL::compact","FIELDSET::disabled","FONT::color","FONT::face","FONT::size","FORM::accept","FORM::autocomplete","FORM::enctype","FORM::method","FORM::name","FORM::novalidate","FORM::target","FRAME::name","H1::align","H2::align","H3::align","H4::align","H5::align","H6::align","HR::align","HR::noshade","HR::size","HR::width","HTML::version","IFRAME::align","IFRAME::frameborder","IFRAME::height","IFRAME::marginheight","IFRAME::marginwidth","IFRAME::width","IMG::align","IMG::alt","IMG::border","IMG::height","IMG::hspace","IMG::ismap","IMG::name","IMG::usemap","IMG::vspace","IMG::width","INPUT::accept","INPUT::accesskey","INPUT::align","INPUT::alt","INPUT::autocomplete","INPUT::autofocus","INPUT::checked","INPUT::disabled","INPUT::inputmode","INPUT::ismap","INPUT::list","INPUT::max","INPUT::maxlength","INPUT::min","INPUT::multiple","INPUT::name","INPUT::placeholder","INPUT::readonly","INPUT::required","INPUT::size","INPUT::step","INPUT::tabindex","INPUT::type","INPUT::usemap","INPUT::value","INS::datetime","KEYGEN::disabled","KEYGEN::keytype","KEYGEN::name","LABEL::accesskey","LABEL::for","LEGEND::accesskey","LEGEND::align","LI::type","LI::value","LINK::sizes","MAP::name","MENU::compact","MENU::label","MENU::type","METER::high","METER::low","METER::max","METER::min","METER::value","OBJECT::typemustmatch","OL::compact","OL::reversed","OL::start","OL::type","OPTGROUP::disabled","OPTGROUP::label","OPTION::disabled","OPTION::label","OPTION::selected","OPTION::value","OUTPUT::for","OUTPUT::name","P::align","PRE::width","PROGRESS::max","PROGRESS::min","PROGRESS::value","SELECT::autocomplete","SELECT::disabled","SELECT::multiple","SELECT::name","SELECT::required","SELECT::size","SELECT::tabindex","SOURCE::type","TABLE::align","TABLE::bgcolor","TABLE::border","TABLE::cellpadding","TABLE::cellspacing","TABLE::frame","TABLE::rules","TABLE::summary","TABLE::width","TBODY::align","TBODY::char","TBODY::charoff","TBODY::valign","TD::abbr","TD::align","TD::axis","TD::bgcolor","TD::char","TD::charoff","TD::colspan","TD::headers","TD::height","TD::nowrap","TD::rowspan","TD::scope","TD::valign","TD::width","TEXTAREA::accesskey","TEXTAREA::autocomplete","TEXTAREA::cols","TEXTAREA::disabled","TEXTAREA::inputmode","TEXTAREA::name","TEXTAREA::placeholder","TEXTAREA::readonly","TEXTAREA::required","TEXTAREA::rows","TEXTAREA::tabindex","TEXTAREA::wrap","TFOOT::align","TFOOT::char","TFOOT::charoff","TFOOT::valign","TH::abbr","TH::align","TH::axis","TH::bgcolor","TH::char","TH::charoff","TH::colspan","TH::headers","TH::height","TH::nowrap","TH::rowspan","TH::scope","TH::valign","TH::width","THEAD::align","THEAD::char","THEAD::charoff","THEAD::valign","TR::align","TR::bgcolor","TR::char","TR::charoff","TR::valign","TRACK::default","TRACK::kind","TRACK::label","TRACK::srclang","UL::compact","UL::type","VIDEO::controls","VIDEO::height","VIDEO::loop","VIDEO::mediagroup","VIDEO::muted","VIDEO::preload","VIDEO::width"]),[P.h])
C.T=H.y(I.ae(["HEAD","AREA","BASE","BASEFONT","BR","COL","COLGROUP","EMBED","FRAME","FRAMESET","HR","IMAGE","IMG","INPUT","ISINDEX","LINK","META","PARAM","SOURCE","STYLE","TITLE","WBR"]),[P.h])
C.U=H.y(I.ae([]),[P.h])
C.y=I.ae([])
C.p=H.y(I.ae(["bind","if","ref","repeat","syntax"]),[P.h])
C.q=H.y(I.ae(["A::href","AREA::href","BLOCKQUOTE::cite","BODY::background","COMMAND::icon","DEL::cite","FORM::action","IMG::src","INPUT::src","INS::cite","Q::cite","VIDEO::poster"]),[P.h])
C.V=H.y(I.ae([]),[P.aA])
C.z=new H.fb(0,{},C.V,[P.aA,null])
C.W=new H.cm("call")
$.a3=0
$.aL=null
$.cY=null
$.cy=!1
$.er=null
$.em=null
$.ex=null
$.bM=null
$.bO=null
$.cJ=null
$.aE=null
$.aU=null
$.aV=null
$.cz=!1
$.q=C.i
$.a9=null
$.c1=null
$.dd=null
$.dc=null
$.d8=null
$.d7=null
$.d6=null
$.d5=null
$=null
init.isHunkLoaded=function(a){return!!$dart_deferred_initializers$[a]}
init.deferredInitialized=new Object(null)
init.isHunkInitialized=function(a){return init.deferredInitialized[a]}
init.initializeLoadedHunk=function(a){var z=$dart_deferred_initializers$[a]
if(z==null)throw"DeferredLoading state error: code with hash '"+a+"' was not loaded"
z($globals$,$)
init.deferredInitialized[a]=true}
init.deferredLibraryParts={}
init.deferredPartUris=[]
init.deferredPartHashes=[];(function(a){for(var z=0;z<a.length;){var y=a[z++]
var x=a[z++]
var w=a[z++]
I.$lazy(y,x,w)}})(["bq","$get$bq",function(){return H.cI("_$dart_dartClosure")},"c8","$get$c8",function(){return H.cI("_$dart_js")},"dH","$get$dH",function(){return H.a6(H.bG({
toString:function(){return"$receiver$"}}))},"dI","$get$dI",function(){return H.a6(H.bG({$method$:null,
toString:function(){return"$receiver$"}}))},"dJ","$get$dJ",function(){return H.a6(H.bG(null))},"dK","$get$dK",function(){return H.a6(function(){var $argumentsExpr$='$arguments$'
try{null.$method$($argumentsExpr$)}catch(z){return z.message}}())},"dO","$get$dO",function(){return H.a6(H.bG(void 0))},"dP","$get$dP",function(){return H.a6(function(){var $argumentsExpr$='$arguments$'
try{(void 0).$method$($argumentsExpr$)}catch(z){return z.message}}())},"dM","$get$dM",function(){return H.a6(H.dN(null))},"dL","$get$dL",function(){return H.a6(function(){try{null.$method$}catch(z){return z.message}}())},"dR","$get$dR",function(){return H.a6(H.dN(void 0))},"dQ","$get$dQ",function(){return H.a6(function(){try{(void 0).$method$}catch(z){return z.message}}())},"cq","$get$cq",function(){return P.iR()},"aW","$get$aW",function(){return[]},"d4","$get$d4",function(){return{}},"e3","$get$e3",function(){return P.dn(["A","ABBR","ACRONYM","ADDRESS","AREA","ARTICLE","ASIDE","AUDIO","B","BDI","BDO","BIG","BLOCKQUOTE","BR","BUTTON","CANVAS","CAPTION","CENTER","CITE","CODE","COL","COLGROUP","COMMAND","DATA","DATALIST","DD","DEL","DETAILS","DFN","DIR","DIV","DL","DT","EM","FIELDSET","FIGCAPTION","FIGURE","FONT","FOOTER","FORM","H1","H2","H3","H4","H5","H6","HEADER","HGROUP","HR","I","IFRAME","IMG","INPUT","INS","KBD","LABEL","LEGEND","LI","MAP","MARK","MENU","METER","NAV","NOBR","OL","OPTGROUP","OPTION","OUTPUT","P","PRE","PROGRESS","Q","S","SAMP","SECTION","SELECT","SMALL","SOURCE","SPAN","STRIKE","STRONG","SUB","SUMMARY","SUP","TABLE","TBODY","TD","TEXTAREA","TFOOT","TH","THEAD","TIME","TR","TRACK","TT","U","UL","VAR","VIDEO","WBR"],P.h)},"ct","$get$ct",function(){return P.dm(P.h,P.af)},"d3","$get$d3",function(){return P.dx("^\\S+$",!0,!1)},"cF","$get$cF",function(){return H.d(P.el(self),"$isai")},"cs","$get$cs",function(){return H.cI("_$dart_dartObject")},"cv","$get$cv",function(){return function DartObject(a){this.o=a}}])
I=I.$finishIsolateConstructor(I)
$=new I()
init.metadata=["error","stackTrace",null,"element","attributeName","value","context","o","index","closure","numberOfArguments","arg1","arg2","arg3","arg4","_","arg","promiseValue","promiseError","e","attr","n","callback","captureThis","self","arguments"]
init.types=[{func:1,ret:P.w},{func:1,ret:P.k},{func:1,ret:P.k,args:[,]},{func:1,ret:P.k,args:[W.T]},{func:1,ret:-1},{func:1,ret:P.z},{func:1,args:[,]},{func:1,ret:-1,args:[,]},{func:1,ret:P.aI,args:[K.a_]},{func:1,ret:[P.H,P.k],args:[P.h,W.o]},{func:1,ret:-1,args:[{func:1,ret:-1}]},{func:1,ret:P.z,args:[W.o,P.h,P.h,W.ba]},{func:1,ret:P.z,args:[W.n]},{func:1,ret:P.k,args:[,,]},{func:1,ret:P.h,args:[P.w]},{func:1,ret:P.z,args:[W.a5]},{func:1,ret:P.z,args:[P.h]},{func:1,ret:P.k,args:[P.w,O.v]},{func:1,ret:P.k,args:[,P.O]},{func:1,ret:P.h,args:[W.aP]},{func:1,ret:P.k,args:[W.b8]},{func:1,ret:-1,args:[P.h,P.h]},{func:1,args:[W.U]},{func:1,args:[P.h]},{func:1,ret:P.k,args:[P.w,,]},{func:1,ret:P.h,args:[P.h]},{func:1,ret:-1,args:[W.n,W.n]},{func:1,ret:P.z,args:[[P.ac,P.h]]},{func:1,ret:W.o,args:[W.n]},{func:1,ret:P.cb,args:[,]},{func:1,ret:[P.ca,,],args:[,]},{func:1,ret:P.ai,args:[,]},{func:1,ret:-1,args:[P.b],opt:[P.O]},{func:1,ret:P.k,args:[W.U]},{func:1,ret:P.k,args:[P.aB]},{func:1,ret:P.k,args:[W.b6]},{func:1,ret:P.b,args:[,]},{func:1,ret:[P.t,,]},{func:1,ret:P.h},{func:1,ret:-1,opt:[P.b]},{func:1,ret:P.k,args:[,],opt:[,]},{func:1,ret:P.z,args:[K.a_]},{func:1,ret:[P.P,,],args:[,]},{func:1,ret:N.bt},{func:1,ret:-1,args:[P.w,O.v]},{func:1,args:[,P.h]},{func:1,ret:P.k,args:[O.v]},{func:1,ret:O.v},{func:1,ret:P.k,args:[F.au]},{func:1,ret:F.au},{func:1,ret:P.k,args:[P.aA,,]},{func:1,ret:[P.H,P.k],args:[P.w,O.v]},{func:1,ret:W.br},{func:1,ret:P.k,args:[{func:1,ret:-1}]},{func:1,ret:P.k,args:[P.h,,]},{func:1,ret:P.k,args:[W.b1]}]
function convertToFastObject(a){function MyClass(){}MyClass.prototype=a
new MyClass()
return a}function convertToSlowObject(a){a.__MAGIC_SLOW_PROPERTY=1
delete a.__MAGIC_SLOW_PROPERTY
return a}A=convertToFastObject(A)
B=convertToFastObject(B)
C=convertToFastObject(C)
D=convertToFastObject(D)
E=convertToFastObject(E)
F=convertToFastObject(F)
G=convertToFastObject(G)
H=convertToFastObject(H)
J=convertToFastObject(J)
K=convertToFastObject(K)
L=convertToFastObject(L)
M=convertToFastObject(M)
N=convertToFastObject(N)
O=convertToFastObject(O)
P=convertToFastObject(P)
Q=convertToFastObject(Q)
R=convertToFastObject(R)
S=convertToFastObject(S)
T=convertToFastObject(T)
U=convertToFastObject(U)
V=convertToFastObject(V)
W=convertToFastObject(W)
X=convertToFastObject(X)
Y=convertToFastObject(Y)
Z=convertToFastObject(Z)
function init(){I.p=Object.create(null)
init.allClasses=map()
init.getTypeFromName=function(a){return init.allClasses[a]}
init.interceptorsByTag=map()
init.leafTags=map()
init.finishedClasses=map()
I.$lazy=function(a,b,c,d,e){if(!init.lazies)init.lazies=Object.create(null)
init.lazies[a]=b
e=e||I.p
var z={}
var y={}
e[a]=z
e[b]=function(){var x=this[a]
if(x==y)H.kB(d||a)
try{if(x===z){this[a]=y
try{x=this[a]=c()}finally{if(x===z)this[a]=null}}return x}finally{this[b]=function(){return this[a]}}}}
I.$finishIsolateConstructor=function(a){var z=a.p
function Isolate(){var y=Object.keys(z)
for(var x=0;x<y.length;x++){var w=y[x]
this[w]=z[w]}var v=init.lazies
var u=v?Object.keys(v):[]
for(var x=0;x<u.length;x++)this[v[u[x]]]=null
function ForceEfficientMap(){}ForceEfficientMap.prototype=this
new ForceEfficientMap()
for(var x=0;x<u.length;x++){var t=v[u[x]]
this[t]=z[t]}}Isolate.prototype=a.prototype
Isolate.prototype.constructor=Isolate
Isolate.p=z
Isolate.ae=a.ae
Isolate.cG=a.cG
return Isolate}}!function(){var z=function(a){var t={}
t[a]=1
return Object.keys(convertToFastObject(t))[0]}
init.getIsolateTag=function(a){return z("___dart_"+a+init.isolateTag)}
var y="___dart_isolate_tags_"
var x=Object[y]||(Object[y]=Object.create(null))
var w="_ZxYxX"
for(var v=0;;v++){var u=z(w+"_"+v+"_")
if(!(u in x)){x[u]=1
init.isolateTag=u
break}}init.dispatchPropertyName=init.getIsolateTag("dispatch_record")}();(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!='undefined'){a(document.currentScript)
return}var z=document.scripts
function onLoad(b){for(var x=0;x<z.length;++x)z[x].removeEventListener("load",onLoad,false)
a(b.target)}for(var y=0;y<z.length;++y)z[y].addEventListener("load",onLoad,false)})(function(a){init.currentScript=a
if(typeof dartMainRunner==="function")dartMainRunner(F.eu,[])
else F.eu([])})})()
//# sourceMappingURL=main.dart.js.map
