<template>
    <transition name="modal">
        <div :id="id" class="modal-mask">
            <div class="modal-wrapper" @click="$router.go(-1)">
                <div tabindex="-1" role="dialog" @click.stop="">
                    <div class="modal-container" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <!-- <a href="#" @click="$router.go(-1)">back</a> -->
                                <h5 class="modal-title">Modal title</h5>
                                <a href="#" @click="$router.go(-1)">x</a>
                                <!-- <router-link to="../">X</router-link> -->
                            </div>
                            <div class="modal-body">
                                <p>{{post?.id}}</p>
                                <p>{{post?.body}}</p>
                                <router-link
                                    tag="div"
                                    :to="`/home/file/`+ (Math.floor(Math.random() * 100)+1)"
                                    :key="$route.path"
                                >
                                    <strong><a>To another post</a></strong>
                                    <br />
                                </router-link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </transition>
</template>
<script>
export default {
    props: ["id"],
    data() {
        return {
            post: null
        }
    },
    created() {
        this.callApi(this.id)
    },
    methods: {
        async callApi() {
            if(this.id) {
                fetch('https://jsonplaceholder.typicode.com/posts/'+this.id)
                .then(response => response.json())
                .then(json => {
                    this.post = json
                })
            }
        },
        test() {
            // this.$router.back()
            console.log("abccacaca");
        }
    },
    watch: {
        '$route.params.id': {
            async handler(newVal, oldVal) {
                if(newVal) {
                    await this.callApi(newVal)
                    // console.log('$("#"+ this.$route.params.id)', $("#"+ this.$route.params.id)ơ);
                    // $("#"+ this.$route.params.id)[0].style.display = 'block'
                }
                
            },
            immediate: true
        } 
    }
}
</script>
<style scoped>
.modal-mask {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, .5);
    display: table;
    transition: opacity .3s ease;
}
.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
} 
.modal-container {
  width: 80%;
  margin: 0px auto;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

 .modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>