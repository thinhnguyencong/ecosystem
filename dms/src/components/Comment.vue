<template>
    <div>
        <div v-if="documentState.file?.comments?.length>0"> 
            <div class="comment-widgets">
                <div v-for="(comment, index) in comments" :key="index" class="d-flex flex-row comment-row">
                    <div class="p-2"><span class="round"><img src="https://www.pngitem.com/pimgs/m/421-4212341_default-avatar-svg-hd-png-download.png" alt="user" width="40"></span></div>
                    <div class="p-2 comment-text w-100">
                        <h5 class="d-inline">{{ comment.name }}</h5> &nbsp; &nbsp; &nbsp;<small class="date">{{customTime(comment.createdAt)}}</small>
                        <p class="m-b-5 m-t-10">{{comment.content}}</p>
                        <a class="attach-text" v-if="comment.attachments.length" role="button" @click="handleShow(comment)">{{ comment.attachments.length }} Attachment(s)</a>
                        <div v-show="comment.isActive">
                            <div class="list-group">
                                <router-link
                                    tag="div"
                                    v-for="(attachment, index) in comment.attachments"
                                    :key="index"
                                    :to="$route.matched[0].name == 'Directory' ? `/folder/${$route.params.id}/file/${attachment.id}` : `${$route.matched[0].path}/file/${attachment.id}`"
                                >
                                    <a class="list-group-item list-group-item-action">
                                        {{ (index+1)+". " }}{{attachment.name}}
                                    </a>
                                </router-link>
                                    
                            </div>

                        </div>
                    </div>
                </div>
                
            </div>
        </div>
        <div v-else> 
            No comment yet
        </div>
        <Transition name="modal">
            <router-view v-if="showModal"></router-view>
        </Transition>
    </div>
</template>
<script>
import $ from 'jquery' 
export default {
    props: {},
    data() {
        return {
            comments: [],
            showModal: false
        }
    },
    methods: {
        openModal(id) {
            $("#attach-"+id).modal('toggle');
        },
        customTime(time) {
            return dayjs(time).fromNow();
        },
        handleShow(comment) {
            comment.isActive = !comment.isActive;
        },
        sortComment(comments) {
            if (comments.length == 1 || comments.length == 0) {
                return comments;
            }
            return comments.sort((a, b) => b.createdAt - a.createdAt);
        },
    },
    created() {
    },
    mounted() {
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    watch: {
        '$route': {
            immediate: true,
            handler: function(newVal, oldVal) {
                this.showModal = newVal.meta && newVal.meta.showModal;
            }
        } ,
        '$store.state.document.file.comments':{
            handler(newVal, oldVal) {
                if(newVal && JSON.stringify(newVal) !== JSON.stringify(oldVal)) {
                    this.$set(this, 'comments', this.sortComment(newVal.map(x => ({ ...x, isActive: false }))))
                }
            },
            immediate: true,
        },
    },
}
</script>
<style scoped>


.comment-widgets .comment-row:hover {
    background: rgba(0, 0, 0, 0.02);
}

.comment-widgets .comment-row {
    border-bottom: 1px solid rgba(120, 130, 140, 0.13);
}
.comment-text:hover{
    visibility: hidden;
}
.comment-text:hover{
    visibility: visible;
}

.label {
    padding: 3px 10px;
    line-height: 13px;
    color: #ffffff;
    font-weight: 400;
    border-radius: 4px;
    font-size: 75%;
}

.round img {
    border-radius: 100%;
}

.label-info {
    background-color: #1976d2;
}

.label-success {
    background-color: green;
}

.label-danger {
    background-color: #ef5350;
}

.action-icons a {
    padding-left: 7px;
    vertical-align: middle;
    color: #99abb4;
}

.action-icons a:hover {
    color: #1976d2;
}

.mt-100 {
    margin-top: 100px
}

.mb-100 {
    margin-bottom: 100px
}
.attach-text {
    color: #1976d2;
}
.attach-text :hover{
    color: #1976d2;
    text-decoration: underline;
}

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
  transition: opacity 0.5s ease;
}
</style>