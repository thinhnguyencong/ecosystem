<template>
	<div >
        <NavBar @onLayoutChange="onLayoutChange"/>
        <div class="pl-4 pr-4 pt-3" v-if="!documentState.isLoading">
            <div class="row">
                <div class="col">
                    <MainView :folders="[]" :files="sortByUnixTimestamps(documentState.recentFiles.slice(), 'lastAccess')" :layoutProps="layout"/>
                </div>
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
import ModalFileDetails from './modal/ModalFileDetails.vue';
import { getLayoutOfPage, sortByUnixTimestamps } from '../../helpers';
import $ from "jquery"
import NavBar from '../../components/layout/NavBar.vue';
import MainView from '../../components/MainView.vue';

</script>
<script>

export default {
    components: { ModalFileDetails, NavBar, MainView },
    mounted() {
        this.$router.push(this.$route.path)
        this.layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route)
    },
    created() {
        this.callAPI()
    },
    data() {
        return {
            layout: "",
            showModal: false,
            sortByUnixTimestamps: sortByUnixTimestamps
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
        authState() {return this.$store.state.auth },
    },
    methods: {
        async callAPI() {
            this.$store.dispatch("auth/sidebarActive", "recent")
            await this.$store.dispatch("document/getRecentDocuments") 
        },
        onLayoutChange(layout) {
            this.layout = layout
            console.log(layout);
        }
    },
    watch: {
        '$route': {
            immediate: true,
            handler: async function(newVal, oldVal) {
                console.log(newVal, oldVal);
                this.layout = await getLayoutOfPage(this.authState.user.publicAddress, newVal)
            }
        },
    }
  }
</script>

<style scoped>

</style>