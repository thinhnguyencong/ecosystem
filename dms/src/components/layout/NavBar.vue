<template>
    <div class="nav-content" >
        <nav v-if="$route.matched[0].name == 'Home'" aria-label="breadcrumb"  class="nav-content--home">
            <ol class="bgc-navbar">
                <li class="breadcrumb-item active d-flex flex-row" aria-current="page" >
                    <div class="folder-account" @click="btnShowModalFile">
                        <img src="@/assets/img/folder-folder.svg" alt="error-foloderIcon">
                        <img id="icon-arrorBottom" src="@/assets/img/arrow_bottom.svg" alt="error-icon">
                        <div class="modal-icon--folder">
                            <modal-folder-icon v-if="isModalFile"/>
                        </div>
                    </div>
                    <span class="mt-1 txtMenu">&nbsp;Home</span>
                </li>
            </ol>
        </nav>




        <nav v-if="$route.matched[0].name == 'My Folder'" aria-label="breadcrumb" >
            <ol class="bgc-navbar">
                <li class="breadcrumb-item active d-flex flex-row" aria-current="page" >
                        <div class="folder-account" @click="btnShowModalFile">
                            <img src="@/assets/img/folder-folder.svg" alt="error-foloderIcon">
                            <img id="icon-arrorBottom" src="@/assets/img/arrow_bottom.svg" alt="error-icon">
                            <div class="modal-icon--folder">
                                <modal-folder-icon v-if="isModalFile"/>
                            </div>
                        </div>
                    <span class="mt-1">&nbsp;My Folder</span>
                </li>
                <li class="ml-auto option-item">
                    <div class="folder-Starred">Starred</div>
                    <img src="@/assets/img/arrow-down.svg" alt="error-arrowDown">
                    <v-btn @click="switchLayout" flat icon color="indigo">
                        <img src="@/assets/img/option.svg" alt="error-option" v-if="iconMenu">
                        <v-icon v-if="layout == 'list'" data-toggle="tooltip" title="" color="black">
                            <img src="@/assets/img/star.svg" alt="error-option" v-if="iconMenu">
                        </v-icon>
                    </v-btn>

                </li>
            </ol>
        </nav>


        <nav v-if="$route.matched[0].name == 'Recent'" aria-label="breadcrumb" >
            <ol class="breadcrumb">
                <li class="breadcrumb-item active d-flex flex-row " aria-current="page">
                    <span class="material-icons">history</span>
                    <span class="mt-1 txtMenu">&nbsp;Recent</span>
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
        <nav v-if="$route.matched[0].name == 'Shared With Me'" aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active d-flex flex-row" aria-current="page">
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



        <nav v-if="$route.matched[0].name == 'Directory'" aria-label="breadcrumb">
            <ol class="bgc-navbar">

                <li aria-current="page">
                    <div class="folder-account" @click="btnShowModalFile">
                        <img src="@/assets/img/folder-folder.svg" alt="error-foloderIcon">
                        <img id="icon-arrorBottom" src="@/assets/img/arrow_bottom.svg" alt="error-icon">
                        <div class="modal-icon--folder">
                            <modal-folder-icon v-if="isModalFile"/>
                        </div>
                    </div>
                </li>
                <li v-if="documentState.folder.status=='my-folder'"  aria-current="page">
                    <router-link class="d-flex flex-row folder-name" to="/my-folder">
                        <span class="txtMenu">&nbsp;My Folder</span>
                    </router-link>
                </li>
                <li v-else-if="documentState.folder.status=='shared-with-me'"  aria-current="page">
                    <router-link class="d-flex flex-row" to="/shared-with-me">
                        <span class="material-icons">folder_shared</span>
                        <span class="mt-1 txtMenu">&nbsp;Shared with me</span>
                    </router-link>
                </li>
                <li v-else class="align-self-center ml-4" aria-current="page">
                    <router-link class="d-flex flex-row" to="/">
                        <span class="material-icons">folder</span>
                        <span class="mt-1 txtMenu">&nbsp;Home </span>
                    </router-link>
                </li>
                <li v-for="(folder, index) in documentState.ancestors" :key="index" class="align-self-center" aria-current="page">
                    <router-link class="align-self-center d-flex flex-row" :to="'/folder/'+ folder._id">
                        <span class="material-icons">
                            &nbsp;/ folder
                        </span>
                        <span class="align-self-center mt-1">&nbsp;{{folder.name}}</span>
                    </router-link>
                    <!-- <router-link v-else to="#">
                        <span class="material-icons">
                            &nbsp;/ home
                        </span>
                    </router-link> -->
                </li>
                <li v-if="documentState.folder" class="d-flex flex-row bgc-navbar align-self-center" aria-current="page">

                    <div><img src="@/assets/img/arrow_right.svg" alt=""></div>
                    <span class="mt-0-5 text-secondary">
                        &nbsp;{{documentState.folder.name}}
                    </span>
                </li>

<!--                <li class="optionMenuDetail">-->
<!--                    <v-btn @click="switchLayout" flat icon color="indigo">-->
<!--                        <v-icon v-if="layout == 'grid'" data-toggle="tooltip" title="" color="black">-->
<!--                            list-->
<!--                        </v-icon>-->
<!--                        <v-icon v-if="layout == 'list'" data-toggle="tooltip" title="" color="black">-->
<!--                            grid_view-->
<!--                        </v-icon>-->
<!--                    </v-btn>-->
<!--                    <v-btn @click="handleDrawer" flat icon color="indigo">-->
<!--                        <v-icon data-toggle="tooltip" title="" color="black">-->
<!--                            info-->
<!--                        </v-icon>-->
<!--                    </v-btn>-->
<!--                </li>-->
            </ol>
        </nav>
    </div>
    
</template>
<script setup>
import ModalFolderIcon from "@/views/main/modal/ModalFolderIcon.vue";
</script>
<script>
import { RouterLink } from 'vue-router';
import { getLayoutOfPage, setLayoutOfPage } from '../../helpers'
export default {
    component() {
        ModalFolderIcon
    },
    mounted() {
        let layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route);
        this.layout = layout;
        this.$emit("onLayoutChange", layout);
    },
    data() {
        return {
            layout: "",
            isModalFile:false,
            iconMenu:true,
        };
    },
    methods: {
        isOption(iconMenu) {
            this.iconMenu = iconMenu
        },
        isShowModalFile(isModalFile) {
            this.isModalFile = isModalFile
        },
        btnShowModalFile () {
            this.isModalFile = ! this.isModalFile
        },
        switchLayout() {
            this.iconMenu = ! this.iconMenu
            if (this.layout === "list") {
                setLayoutOfPage(this.authState.user.publicAddress, this.$route, "grid");
                this.layout = "grid";
                this.$emit("onLayoutChange", "grid");
            }
            else if (this.layout === "grid") {
                this.layout = "list";
                setLayoutOfPage(this.authState.user.publicAddress, this.$route, "list");
                this.$emit("onLayoutChange", "list");
            }
        },
        handleDrawer() {
            this.$emit("handleDrawer", "list");
        }
    },
    computed: {
        documentState() { return this.$store.state.document; },
        authState() { return this.$store.state.auth; },
    },
    watch: {
        "$route.params.id": {
            handler(newVal, oldVal) {
                if (newVal !== oldVal) {
                    this.layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route);
                }
            },
            immediate: true
        },
    },
    components: {ModalFolderIcon, RouterLink }
}
</script>
<style scoped>
@import "@/assets/style/_theme.scss";

.nav-content--home {
    padding: 16px;
}

ol , ul {
    margin: 0;
}
.breadcrumb-item {
    display: flex;
    align-items: center;
    gap: 0 4px;
}
.option-item {
    display: flex;
    align-items: center;
    gap:  0 8px;
}
.bgc-navbar {
    display: flex;
    align-items: center;
    gap: 0 8px;
}
ol,ul {
    padding: 0;
}

button::before {
    background-color: var(--background) !important;
}
button::before:focus {
    background-color: var(--background) !important;
}
button::before:active {
    background-color: var(--background) !important;
}

li {
    list-style: none !important;
}
.folder-name {
    font-size: 12px;
    color: var(--text-color-txt);

}
.folder-account {
    display: flex;
    align-items: center;
    gap:  0 4px;
    padding: 4px;
    background: var(--bgc-item--folder);
    border: 1px solid var(--border-color);
    border-radius: 8px;
    cursor: pointer;
    position: relative;
    .modal-icon--folder {
        position: absolute;
        top: 30px;
        left: 0;
    }
}
#icon-arrorBottom {
    width: 8px;
    height: 8px;
}
</style>