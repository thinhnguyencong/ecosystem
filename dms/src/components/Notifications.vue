<template>
    <div class="">
        <header class="ml-3 h5">
            <strong>Notifications</strong>
        </header>
        <div v-if="toBeShown.length">
            <div v-for="(noti,pIndex) in sortNotification(toBeShown)" :key="pIndex">
                <div v-if="noti.type == 'file'">
                    <router-link :to="'/file/'+ noti.documentId" style="text-decoration: none; color: inherit;">  
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
                    <router-link :to="'/folder/'+ noti.documentId" style="text-decoration: none; color: inherit;">
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
            <a href="#" v-if="currentPage!==1" type="button"  @click.stop="prevPage">Show less</a>
            <a href="#" v-if="currentPage !== totalPages && toBeShown.length" type="button"  @click.stop="nextPage">Show more</a>
        </footer>
    </div>
</template>
<script>
export default {
    mounted() {
        this.$store.dispatch("user/getNotifications")
    },
    data() {
        return {
            currentPage: 1,
            notifications: [
            
            ]
        }
    },
    computed:{
        userState() {
            return this.$store.state.user;
        },
        toBeShown() {
            this.notifications = this.userState.notifications
            return this.notifications.slice(0, this.currentPage * 3);
        },
        totalPages() {
            return Math.ceil( this.notifications.length / 3);
        }
    },
    methods: {
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
            if (noti.length == 1 || noti.length == 0) {
                return noti;
            }
            return noti.sort((a, b) =>  dayjs(b.createdAt).unix() - dayjs(a.createdAt).unix());
        },
    },
    watch: {
        'userState.notifications':{
            handler(newVal, oldVal) {
                console.log(newVal, oldVal);
                if(newVal && JSON.stringify(newVal) !== JSON.stringify(oldVal)) {
                    this.notifications = this.userState.notifications
                }
            },
            immediate: true,
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
</style>