<template>
	<div>
        <NavBar @onLayoutChange="onLayoutChange" @handleDrawer="handleDrawer"/>
        <div class="pl-4 pr-4" v-if="!documentState.isLoading">
            <div v-if="layout == 'grid'">
                <GridViewVue :folders="documentState.children" :files="[]"/>
            </div>
            <div v-if="layout == 'list'">
                <ListView :folders="documentState.children" :files="[]" :hasStatus="false"/>
            </div>
        </div>
        <div v-else class="pl-4 pr-4">
            <div class="spinner-border text-dark" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div> 
	</div>
</template>
<script setup>
import GridViewVue from '../components/GridView.vue';
import NavBar from '../components/layout/NavBar.vue';
import ListView from '../components/ListView.vue';
</script>
<script>

export default {
  components: { File, ListView, NavBar },
    mounted() {
        // Call the API query method on page load
        this.$router.push(this.$route.path)
    },
    created() {
        this.$store.dispatch("auth/sidebarActive", "shared-with-me")
        this.$store.dispatch("document/getSharedWithMeFolders")       
    },
    data() {
        return {
           layout: "grid",
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    methods: {
        onLayoutChange(layout) {
            this.layout = layout
        },
        handleDrawer() {
            console.log(this.drawerVisible);
            this.drawerVisible = !this.drawerVisible
            console.log(this.drawerVisible);
            if(this.drawerVisible) {
                this.transition = 'slide-fade-reverse'
            }else {
                this.transition = 'slide-fade'
            }
        }
    },
  }
</script>

<style scoped>

</style>