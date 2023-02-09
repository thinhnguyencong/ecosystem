<template>
    <div>
        <nav v-if="$route.matched[0].name == 'Home'" aria-label="breadcrumb" class="mt-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active d-flex flex-row ml-4 align-self-center" aria-current="page">
                    <span class="material-icons align-self-center">home</span>
                    <span class="mt-1">&nbsp;Home</span>
                </li>
                <li class="ml-auto mr-5">
                    <v-btn @click="switchLayout" flat icon color="indigo">
                        <v-icon v-if="layout == 'grid'" data-toggle="tooltip" title="" color="black">
                            list
                        </v-icon>
                        <v-icon v-if="layout == 'list'" data-toggle="tooltip" title="" color="black">
                            grid_view
                        </v-icon>
                    </v-btn>
                </li>
            </ol>
        </nav>
        <nav v-if="$route.matched[0].name == 'My Folder'" aria-label="breadcrumb" class="mt-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active d-flex flex-row ml-4 align-self-center" aria-current="page">
                    <span class="material-icons">folder</span>
                    <span class="mt-1">&nbsp;My Folder</span>
                </li>
                <li class="ml-auto mr-5">
                    <v-btn @click="switchLayout" flat icon color="indigo">
                        <v-icon v-if="layout == 'grid'" data-toggle="tooltip" title="" color="black">
                            list
                        </v-icon>
                        <v-icon v-if="layout == 'list'" data-toggle="tooltip" title="" color="black">
                            grid_view
                        </v-icon>
                    </v-btn>
                    <v-btn @click="handleDrawer" flat icon color="indigo">
                        <v-icon data-toggle="tooltip" title="" color="black">
                            info
                        </v-icon>
                    </v-btn>
                </li>
            </ol>
        </nav>
        <nav v-if="$route.matched[0].name == 'Shared With Me'" aria-label="breadcrumb" class="mt-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active d-flex flex-row ml-4 align-self-center" aria-current="page">
                    <span class="material-icons">folder_shared</span>
                    <span class="mt-1">&nbsp;Share With Me</span>
                </li>
                <li class="ml-auto mr-5">
                    <v-btn @click="switchLayout" flat icon color="indigo">
                        <v-icon v-if="layout == 'grid'" data-toggle="tooltip" title="" color="black">
                            list
                        </v-icon>
                        <v-icon v-if="layout == 'list'" data-toggle="tooltip" title="" color="black">
                            grid_view
                        </v-icon>
                    </v-btn>
                </li>
            </ol>
        </nav>
        <nav v-if="$route.matched[0].name == 'Directory'" aria-label="breadcrumb" class="mt-4">
            <ol class="breadcrumb mt-2">
                <li v-if="documentState.folder.status=='my-folder'" class="ml-4 align-self-center" aria-current="page">
                    <router-link class="d-flex flex-row" to="/my-folder">
                        <span class="material-icons">folder</span>
                        <span class="mt-1">&nbsp;My Folder</span>
                    </router-link>
                </li>
                <li v-else-if="documentState.folder.status=='shared-with-me'" class="ml-4 align-self-center" aria-current="page">
                    <router-link class="d-flex flex-row" to="/shared-with-me">
                        <span class="material-icons">folder_shared</span>
                        <span class="mt-1">&nbsp;Shared with me</span>
                    </router-link>
                </li>
                <li v-else class="align-self-center ml-4" aria-current="page">
                    <router-link class="d-flex flex-row" to="/">
                        <span class="material-icons">folder</span>
                        <span class="mt-1">&nbsp;Home </span>
                    </router-link>
                </li>
                <li v-for="(folder, index) in documentState.ancestors" :key="index" class="align-self-center" aria-current="page">
                    <router-link class="align-self-center d-flex flex-row" :to="'/folder/'+ folder._id">
                        <span class="material-icons">
                            &nbsp;/ folder
                        </span>
                        <span class="align-self-center mt-1">&nbsp;{{folder.name}}</span>
                    </router-link>
                </li>
                <li v-if="documentState.folder" class="d-flex flex-row align-self-center mt-n-2" aria-current="page">
                    
                    <span class="material-icons">
                        &nbsp;/ <i class="mdi mdi-folder-open text-secondary"></i>
                    </span>
                    <span class="mt-0-5 text-secondary">
                        &nbsp;{{documentState.folder.name}}
                    </span>
                </li>
                <li class="ml-auto mr-5">
                    <v-btn @click="switchLayout" flat icon color="indigo">
                        <v-icon v-if="layout == 'grid'" data-toggle="tooltip" title="" color="black">
                            list
                        </v-icon>
                        <v-icon v-if="layout == 'list'" data-toggle="tooltip" title="" color="black">
                            grid_view
                        </v-icon>
                    </v-btn>
                    <v-btn @click="handleDrawer" flat icon color="indigo">
                        <v-icon data-toggle="tooltip" title="" color="black">
                            info
                        </v-icon>
                    </v-btn>
                </li>
            </ol>
        </nav>
    </div>
    
</template>
<script>
import { getLayoutOfPage, setLayoutOfPage } from '../../helpers'
import socket from '../../helpers/socket'
export default {
    mounted() {
        let layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route)
        this.layout = layout
        this.$emit('onLayoutChange', layout);
        if(this.authState.user._id) {
            socket.auth = {userId: this.authState.user._id}
            socket.connect();
        }
    },
    data() {
        return {
            layout: "",
        }
    }, 
    methods: {
        switchLayout() {
            if(this.layout === "list"){
                setLayoutOfPage(this.authState.user.publicAddress, this.$route, "grid")
                this.layout = "grid"
                this.$emit('onLayoutChange', "grid");
            }else if (this.layout === "grid"){
                this.layout = "list"
                setLayoutOfPage(this.authState.user.publicAddress, this.$route, "list")
                this.$emit('onLayoutChange', "list");
            }
        },
        handleDrawer() {
            this.$emit('handleDrawer', "list");
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
        authState() {return this.$store.state.auth },
    },
    watch: {
        '$route.params.id': {
            handler(newVal, oldVal) {
                if(newVal !== oldVal) {
                    this.layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route)
                }
            },
            immediate: true
        },
    },
}
</script>
<style scoped>
.mt-n-2 {
    margin-top: -0.2rem;
}
.mt-0-5 {
    margin-top: 0.5rem;
}
</style>