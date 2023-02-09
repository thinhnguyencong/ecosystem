<template>
    <div class="">
        <header class="ml-3 h5">
            <strong>Notifications</strong>
        </header>
        <div v-for="(noti,pIndex) in toBeShown" :key="pIndex">
            <div v-if="noti.type == 'file'">
                <router-link :to="'/file/'+ noti.documentId" style="text-decoration: none; color: inherit;">      
                    <div class="list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
                        <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                        <small>3 days ago</small>
                    </div>     
                </router-link>
            </div>
            <div v-if="noti.type == 'folder'">
                <router-link :to="'/folder/'+ noti.documentId" style="text-decoration: none; color: inherit;">
                    <div v-if="noti.read">
                        <div class="read list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
                            <div class="d-flex flex-row">
                                <div>
                                    <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                                    <small>3 days ago</small>
                                </div>
                                <div class="material-icons text-primary h5 align-items-center">fiber_manual_record</div>
                            </div>
                        </div>
                    </div>
                    <div v-else>
                        <div class="list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
                            <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                            <small>3 days ago</small>
                        </div>
                    </div>
                    
                </router-link>
            </div>
        </div>
        <footer class="ml-3">
            <a href="#" v-if="currentPage!==1" type="button"  @click.stop="prevPage">Show less</a>
            <a href="#" v-if="currentPage !== totalPages" type="button"  @click.stop="nextPage">Show more</a>
        </footer>
    </div>
</template>
<script>
export default {
    data() {
        return {
            currentPage: 1,
            notifications: [
                {
                    type: 'file',
                    documentId: '63a40d55c1b0a06eac4b44d1',
                    from: 'Nguyen Luong Nguyen',
                    content: 'add a comment on your file.',
                    read: true
                },
                {
                    type: 'folder',
                    documentId: '63a3ffcd2ac37658fa103d60',
                    from: 'Nguyen Luong Nguyen',
                    content: 'share a folder with you.',
                    read: true,
                },
                {
                    type: 'file',
                    documentId: '63a40d55c1b0a06eac4b44d1',
                    from: 'Nguyen Luong Nguyen',
                    content: 'add a comment on your file.',
                    read: true,
                },
                {
                    type: 'folder',
                    documentId: '63a3ffcd2ac37658fa103d60',
                    from: 'Nguyen Luong Nguyen',
                    content: 'share a folder with you.',
                    read: false,
                },
                {
                    type: 'file',
                    documentId: '63a40d55c1b0a06eac4b44d1',
                    from: 'Nguyen Luong Nguyen',
                    content: 'add a comment on your file.',
                    read: false,
                },
                {
                    type: 'folder',
                    documentId: '63a3ffcd2ac37658fa103d60',
                    from: 'Nguyen Luong Nguyen',
                    content: 'share a folder with you.',
                    read: false,
                }
            ]
        }
    },
    computed:{
        toBeShown() {
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
        }
    }
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