
# vue笔记

######   1.vue入门小demo(基本使用)

~~~
<div id="app">
        <!-- {{}}用于标签体内显示数据 -->
        Hello, {{ msg }} <br/>
        Hello2, {{ msg }} <br/>
        <h3 v-text="msg"></h3>
        <!-- v-model进行数据的双向绑定 -->
        <input type="text" v-model="msg">
    </div>
    <div id="app2"></div>
    
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script>
       var vm = new Vue({
            el: '#app', //指定被Vue管理的入口, 值为选择器, 不可以指定body或者是html
            data: { // 用于初始化数据，在Vue实例管理的Dom节点下，可通过模板语法来引用
                msg: 'Vue.js11'
            }
        })
        
    </script>
~~~

###### 2.模板数据绑定渲染

~~~
<!-- 
        {{JS表达式}}
     -->
     <div id="app">
        <h3>1、{{}}双大括号输出文本内容</h3>
        <!-- 文本内容 -->
        <p>{{message}}</p>
        <!-- JS表达式 -->
        <p>{{score + 1}}</p>

        <h3>2、 一次性插值 v-once </h3>
        <span v-once>{{message}}</span>

        <h3>3、指令输出真正的 HTML 内容 v-html</h3>
        <p>双大括号：{{contentHtml}}</p>
        <!-- 
             v-html: 
             1. 如果输出的内容是HTML数据，双大括号将数据以普通文本方式进行输出，
             为了输出真正ＨＴＭＬ的效果，就需要使用v-html 指定
             2. 为了防止 XSS 攻击

         -->
        <p>v-html: <span v-html="contentHtml"></span></p>
         

        <h3>4、元素绑定指令 v-bind</h3>
        <img :src="imgUrl">
        <img :src="imgUrl">
         <a :href="mxgUrl">跳转</a>

         <h3>5、事件绑定指令 v-on</h3>
         <input type="text" value="1" v-model="num">
         <button @click="add">点击+1</button>
     </div>
     <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
     <script>
         var vm = new Vue({
            el: '#app',
            data: {
                message: 'mengxuegu',
                score: 100,
                contentHtml: `<span style="color:red">此内容为红色字体
                    <script>alert('hello mxg')<\/script>
                    </span>`,
                imgUrl: 'https://cn.vuejs.org/images/logo.png',
                mxgUrl: 'http://www.mengxuegu.com',
                num: 10
            },
            methods: { // 指定事件处理函数 v-on:事件名="函数名" 来进行调用
                add: function() { //定义了add函数
                    console.log('add被调用')
                    this.num ++
                }
            }
         })
     </script>
~~~

###### 3.计算器和监听器

~~~
 <div id="app">
        数学：<input type="text" v-model="mathScore">
        英语：<input type="text" v-model="englishScore"><br>
        <!-- v-model调用函数时，不要少了小括号 -->
        总得分（函数-单向绑定）：<input type="text" v-model="sumScore()"><br>
        <!-- 绑定计算属性后面不加上小括号 -->
        总得分（计算属性-单向绑定）：<input type="text" v-model="sumScore1"><br>
        总得分（计算属性-双向绑定）：<input type="text" v-model="sumScore2">

        <!-- 通过 watch 选项 监听数学分数， 当数学更新后回调函数中重新计算总分sumScore3 -->
        总得分（监听器）: <input type="text" v-model="sumScore3">   

    </div>
    <script src="./node_modules/vue/dist/vue.js"></script>
    <script>
        /* 
        1. 函数没有缓存，每次都会被调用
        2. 计算属性有缓存 ，只有当计算属性体内的属性值被更改之后才会被调用，不然不会被调用
        3. 函数只支持单向
        4. 计算属性默认情况下：只有getter函数，而没有setter函数，所以只支持单向
            如果你要进行双向，则需要自定义setter函数
        */
        var vm = new Vue({
            el: '#app',
            data: {
                mathScore: 80,
                englishScore: 90,
                sumScore3: 0 // 通过监听器，计算出来的总得分
            },

            methods: {
                sumScore: function () { //100
                    console.log('sumScore函数被调用')
                    // this 指向的就是 vm 实例 , 减0是为了字符串转为数字运算
                    return (this.mathScore-0) + (this.englishScore-0)
                }
            },

            computed: { //定义计算属性选项
                //这个是单向绑定，默认只有getter方法
                sumScore1: function () { //计算属性有缓存，如果计算属性体内的属性值没有发生改变，则不会重新计算，只有发生改变 的时候才会重新计算
                    console.log('sumScore1计算属性被调用')
                    return (this.mathScore-0) + (this.englishScore-0)
                },

                sumScore2: { //有了setter和getter之后就可以进行双向绑定
                    //获取数据
                    get: function() {
                        console.log('sumScore2.get被调用')
                        return (this.mathScore-0) + (this.englishScore-0)
                    },
                    //设置数据， 当 sumScore2 计算属性更新之后 ，则会调用set方法
                    set: function(newValue) { // newVulue 是 sumScore2 更新之后的新值
                        console.log('sumScore2.set被调用')
                        var avgScore = newValue / 2
                        this.mathScore = avgScore
                        this.englishScore = avgScore
                    }
                }
            },
            
            //监听器，
            watch: {
                //需求：通过 watch 选项 监听数学分数， 当数学更新后回调函数中重新计算总分sumScore3
                mathScore: function(newValue, oldValue) {
                    console.log('watch监听器,监听到了数学分数已经更新')
                    //  newValue 是更新后的值，oldValue更新之前的值
                    this.sumScore3 = (newValue-0) + (this.englishScore-0)
                }
            },
        })

        //监听器方式2: 通过 vm 实例进行调用
        //第1个参数是被监听 的属性名， 第2个是回调函数 
        vm.$watch('englishScore', function(newValue) {
            //newValue就是更新之后的英语分数
            this.sumScore3 = (newValue-0) + (this.mathScore-0)
        })

        vm.$watch('sumScore3', function(newValue) {
            //newValue就是更新之后部分
            var avgScore = newValue / 2
            this.mathScore = avgScore
            this.englishScore = avgScore
        })
    </script>
~~~

