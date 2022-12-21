<template>
    <div class="comment-widgets m-b-20">
        <div v-for="(comment, index) in comments" :key="index" class="d-flex flex-row comment-row">
            <div class="p-2"><span class="round"><img src="https://www.pngitem.com/pimgs/m/421-4212341_default-avatar-svg-hd-png-download.png" alt="user" width="50"></span></div>
            <div class="p-2 comment-text w-100">
                <h5 class="d-inline">{{ comment.name }}</h5> &nbsp; &nbsp; &nbsp;<small class="date">{{customTime(comment.createdAt)}}</small>
                <p class="m-b-5 m-t-10">{{comment.content}}</p>
                <a v-if="comment.attachments.length" href="#" @click="handleShow(comment)">{{ comment.attachments.length }} Attachment(s)</a>
                <div v-show="comment.isActive">
                    <ul>
                        <li v-for="(attachment, index) in comment.attachments">{{attachment.name}}</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
    import ModalFileDetails from '../views/ModalFileDetails.vue';
</script>
<script>
import $ from 'jquery' 

export default {
    props: {
        commentsProp: Array,
    },
    data() {
        return {
            comments: [],
            file:{}
        };
    },
    methods: {
        openModal() {
            // $("#main-"+this.id).modal('toggle');
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
        this.$set(this, "file", {
            _id: "63a2d2eec88980a7b9fb0cbb",
            tokenId: "30",
            hash: "QmVberuyHjLgPu33MUEkeg4WzLqXkKuNPy9rayXnKWj8uD",
            // tokenURI: "{\"hash\":\"QmVberuyHjLgPu33MUEkeg4WzLqXkKuNPy9rayXnKWj8uD\",\"time\":1671615212385,\"name\":\"cryptography4020016.pdf\",\"size\":1113299,\"fileType\":\"application/pdf\",\"lastModified\":1665051054008,\"signers\":[\"0x09876c96f80247184921f24547c861c99083f602\"],\"reviewers\":[\"0xfe47e32e697532bba14ee50458055d1b80de4657\",\"0xff8ce8c35a2222c573352d182c50505010973244\"],\"folder\":\"63a2ced969e69aafba7272e2\"},
            // owner: "63a2ced969e69aafba7272e0",
            // description: "<h2>Dear AB,</h2><p><br></p><h2>Why do we use it?</h2><p class=\"ql-align-justify\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p><p><br></p><h2>Where does it come from?</h2><p class=\"ql-align-justify\">Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p><p class=\"ql-align-justify\">The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p><h2>Where can I get some?</h2><p><br></p>,
            // parentFolder: "63a2ced969e69aafba7272e2",
            shared: [
                "63a2ce8ddba2d1d8fdb18886",
                "63a2ce8ddba2d1d8fdb18888",
                "63a2ce8ddba2d1d8fdb1888c"
            ],
            key: "61644d5179555253654a4f69337a6649",
            isSharedPublic: false,
            comments: [
                {
                userId: "63a2ced969e69aafba7272e0",
                name: "Nguyen Thi Mai Huong",
                content: "Alo a xem qua tài liệu này giúp em nữa",
                attachments: [
                    {
                    id: "63a2d41bc88980a7b9fb0df4",
                    name: "ABCDE.pdf",
                    _id: "63a2d44ec88980a7b9fb0e42"
                    }
                ],
                createdAt: 1671615566847,
                _id: "63a2d44ec88980a7b9fb0e41"
                }
            ],
            createdAt: "2022-12-21T09:33:34.978Z",
            updatedAt: "2022-12-21T09:39:26.848Z",
            __v: 0,
            statusDetail: {
                reviewerList: [
                {
                    name: "Nguyen Minh Hien",
                    address: "0xfe47e32e697532bba14ee50458055d1b80de4657",
                    status: "not-yet-reviewed",
                    time: "0"
                },
                {
                    name: "Pham Van Dam",
                    address: "0xff8ce8c35a2222c573352d182c50505010973244",
                    status: "not-yet-reviewed",
                    time: "0"
                }
                ],
                signerList: [
                {
                    name: "Kim Si Chun",
                    address: "0x09876c96f80247184921f24547c861c99083f602",
                    status: "not-yet-signed",
                    time: "0"
                }
                ]
            },
            status: "waiting-to-review",
            canComment: true,
            canReview: false,
            canSign: false
        })
    },
    mounted() {
        console.log("MOUNTTTTTTTTTTTTTT");
        
        this.$set(this, "comments", this.sortComment(this.commentsProp.map(x => ({ ...x, isActive: false }))));
    },
    watch: {
        commentsProp: function (newVal, oldVal) {
            this.$set(this, "comments", this.sortComment(newVal.map(x => ({ ...x, isActive: false }))));
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
</style>