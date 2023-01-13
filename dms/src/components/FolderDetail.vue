<template>
    <div :style="{width: '0'}">
        <div
        class="right-drawer"
        :style="{
            width: open ? '25vw' : '0',
            paddingLeft: open ? '10px' : '0',
        }"
        >
        <div class="d-flex justify-content-center">
            <div></div>
            <h2 class="align-center">Folder Details</h2>
            <div></div>
        </div>
        
        <br>
        <div class="container">
            <div class="row">
                <div class="col-4">
                    <p class="h5 font-weight-bold">Folder Name</p>
                </div>
                <div class="col-8">
                    <p class="h5">{{ documentState.folder.name }}</p>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-4">
                    <p class="h5 font-weight-bold">Owner</p>
                </div>
                <div class="col-8">
                    <p class="h5">{{ documentState.folder.owner.name }}</p>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-4">
                    <p class="h5 font-weight-bold">Created At</p>
                </div>
                <div class="col-8">
                    <p class="h5">{{ new Date(documentState.folder.createdAt).toDateString() }}</p>
                </div>
            </div>
        </div>
        
        </div>
    </div>
    
</template>
<script>
export default {
    props: ['drawerVisible'],
    data() {
        return {
            open: false,
        };
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    watch: {
        drawerVisible: {
            immediate: true, 
            handler (newVal, oldVal) {
                console.log(newVal);
                this.open = newVal
            }
        }
    }
};
</script>

<style scoped>

.right-drawer {
  display: inline-block;
  top: 0;
  right: 0;
  width: 0; /* initially */
  overflow: hidden;
  height: 100vh;
  padding-left: 0; /* initially */
  border-left: 1px solid whitesmoke;
  background: white;
}

</style>
