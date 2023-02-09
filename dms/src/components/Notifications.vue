<template>
    <div class="">
        <header class="ml-3 h5">
            <strong>Notifications</strong>
        </header>
        <div class="col" v-for="(noti,pIndex) in toBeShown" :key="pIndex">
            <div v-if="noti.type == 'file'">
                <router-link :to="'/file/'+ noti.documentId" class="list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
            
                    <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                    <small>3 days ago</small>
                </router-link>
            </div>
            <div v-if="noti.type == 'folder'">
                <router-link :to="'/folder/'+ noti.documentId" class="list-group-item list-group-item-action flex-column align-items-start border-left-none border-right-none">
            
                    <p class="mb-1"><strong>{{ noti.from }}</strong>  {{ noti.content }}</p>
                    <small>3 days ago</small>
                </router-link>
            </div>
        </div>
        <footer class="ml-3">
            <button class="btn btn-primary" type="button"  @click="prevPage" :disabled="currentPage==1">Show less</button>
            <button class="btn btn-primary" type="button"  @click="nextPage" :disabled="currentPage == totalPages">Show more</button>
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
                    from: 'Nghuyen Luong Nguyen',
                    content: 'add a comment on your file.'
                },
                {
                    type: 'folder',
                    documentId: '63a3ffcd2ac37658fa103d60',
                    from: 'Nghuyen Luong Nguyen',
                    content: 'share a folder with you.'
                },
                {
                    type: 'file',
                    documentId: '63a40d55c1b0a06eac4b44d1',
                    from: 'Nghuyen Luong Nguyen',
                    content: 'add a comment on your file.'
                },
                {
                    type: 'folder',
                    documentId: '63a3ffcd2ac37658fa103d60',
                    from: 'Nghuyen Luong Nguyen',
                    content: 'share a folder with you.'
                },
                {
                    type: 'file',
                    documentId: '63a40d55c1b0a06eac4b44d1',
                    from: 'Nghuyen Luong Nguyen',
                    content: 'add a comment on your file.'
                },
                {
                    type: 'folder',
                    documentId: '63a3ffcd2ac37658fa103d60',
                    from: 'Nghuyen Luong Nguyen',
                    content: 'share a folder with you.'
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
</style>