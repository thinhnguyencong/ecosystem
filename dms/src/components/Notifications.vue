<template>
    <div class="noti-container">
        <header class="ml-3 h5">
            <strong>Notifications</strong>
        </header>
        <div v-if="notifications.length">
            <div v-for="(noti,pIndex) in notifications.slice(0, currentPage * 3)" :key="pIndex">
                <div v-if="noti.type == 'file'">
                    <router-link :to="'/file/'+ noti.documentId" style="text-decoration: none; color: inherit;" @click.native="readNotification(noti._id, noti.read)">  
                        <div v-if="!noti.read">
                            <div class="read list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
                                <div class="d-flex flex-row">
                                    <div>
                                        <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                                        <small>{{customTime(noti.createdAt)}}</small>
                                    </div>
                                    <div class="material-icons text-primary h5 align-items-center">fiber_manual_record</div>
                                </div>
                            </div>
                        </div>
                        <div v-else>
                            <div class="list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
                                <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                                <small>{{customTime(noti.createdAt)}}</small>
                            </div>
                        </div>    
                    </router-link>
                    
                    
                </div>
                <div v-if="noti.type == 'folder'">
                    <router-link :to="'/folder/'+ noti.documentId" style="text-decoration: none; color: inherit;" @click.native="readNotification(noti._id, noti.read)">
                        <div v-if="!noti.read">
                            <div class="read list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
                                <div class="d-flex flex-row">
                                    <div>
                                        <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                                        <small>{{customTime(noti.createdAt)}}</small>
                                    </div>
                                    <div class="material-icons text-primary h5 align-items-center">fiber_manual_record</div>
                                </div>
                            </div>
                        </div>
                        <div v-else>
                            <div class="list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
                                <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                                <small>{{customTime(noti.createdAt)}}</small>
                            </div>
                        </div>
                        
                    </router-link>
                </div>
            </div>
        </div>
        <div v-else>
            <br>
            <p class="ml-3">No notification</p>
        </div>
        
        <footer class="ml-3">
            <div class="d-flex justify-content-between">
                <a class="p-1" href="#" v-if="currentPage !== totalPages && notifications.length" type="button"  @click.stop="nextPage">Show more</a>
                <a class="p-1 text-right pr-4" href="#" v-if="currentPage!==1" type="button"  @click.stop="prevPage">Show less</a>
            </div>
            
        </footer>
    </div>
</template>
<script>
export default {
    mounted() {
        this.initData()
        
    },
    data() {
        return {
            currentPage: 1,
            notifications: []
        }
    },
    computed:{
        userState() {
            return this.$store.state.user;
        },
        totalPages() {
            return Math.ceil( this.notifications.length / 3);
        }
    },
    methods: {
        async initData() {
            await this.$store.dispatch("user/getNotifications")
            this.notifications = this.sortNotification(this.userState.notifications)
        },
        nextPage(){
            if(this.currentPage <  this.totalPages) this.currentPage++;
        },
        prevPage(){
            this.currentPage = this.currentPage - 1 || 1;
        },
        customTime(time) {
            return dayjs(time).fromNow();
        },
        sortNotification(noti) {
            return noti.sort(function(a, b) {
                return new Date(b.createdAt) - new Date(a.createdAt);
            });
        },
        readNotification(id, read) {
            if(!read) {
                this.$store.dispatch("user/readNotification", {notificationId: id})
                this.notifications.find(v => v._id === id).read = true;
                this.notifications.find(v => v._id === id).new = false;
            }
        }
    },
    watch: {
        'userState.notifications': {
            handler(newVal, oldVal) {
                this.notifications = this.sortNotification(JSON.parse(JSON.stringify(newVal)))
            },
            immediate: true,
            deep: true,
        },
    },
}
</script>
<style scoped>
.border-left-none {
    border-left: 0;
}
.border-right-none {
    border-right: 0;
}
.read {
    background-color: aliceblue;
}
.noti-container {
    -ms-overflow-style: none;  /* Internet Explorer 10+ */
    scrollbar-width: none;  /* Firefox */
    overflow-y: scroll; /* Add the ability to scroll */
}
.noti-container::-webkit-scrollbar { 
    display: none;  /* Safari and Chrome */
}
</style>