<template>
    <div>
        <div class="detail-option">
            <a href="#"><img src="@/assets/img/share2.svg" alt="error-share2"></a>
            <a href="#"><img src="@/assets/img/star.svg" alt="error-star"></a>
            <a href="#"><img src="@/assets/img/link.svg" alt="error-link"></a>
            <a href="#"><img src="@/assets/img/dowload-detail.svg" alt="error-download"></a>
            <a href="#"><img src="@/assets/img/copyfile.svg" alt="error-copyfile"></a>
        </div>
        <ul class="detail-file" >
            <li class="detail-parameter">
                <div class="detail-parameter_header">
                    <div class="parameter_header-txt">
                        <img id="detail-active_icon" src="@/assets/img/iconFolder.svg" alt="error-iconFolder">
                        <div class="parameter_header-txt">{{ documentState.folder.name }}</div>
                    </div>
                    <div class="parameter_header-close" @click="btnOfDetail()">
                        <img src="@/assets/img/closeDel.svg" alt="error-closeDel">
                    </div>
                </div>
                <div class="detail-parameter_content">
                    <img id="parameter_content-folder" src="@/assets/img/iconFolder.svg" alt="error-iconFolder">
                </div>
            </li>
            <li class="detail-Properties">
                <div class="detail-Properties-title">Properties</div>
                <div class="detail-Properties-txt">
                    <div class="Properties-txt">Created</div>
                    <div class="Properties-file">{{ new Date(documentState.folder.createdAt).toDateString() }}</div>
                </div>
                <div class="detail-Properties-txt">
                    <div class="Properties-txt">File Size</div>
                    <div class="Properties-file">50 MB</div>
                </div>
                <div class="detail-Properties-txt">
                    <div class="Properties-txt">Item Quantity</div>
                    <div class="Properties-file">25 files</div>
                </div>
            </li>
            <li class="detail-description">
                <div class="detail-description_title">Description</div>
                <div class="detail-description_add">+ Add description</div>
            </li>
            <li class="detail-path">
                <div class="detail-path_title">Path</div>
                <div class="detail-path_txt">
                    <div class="detail-path_folder">
                        My Folder
                    </div>
                    <span class="detail-path_folder">
                              <img src="@/assets/img/arrow_right.svg" alt="error-arrow_right">
                            </span>
                    <div class="detail-path_folder">
                        Block chain
                    </div>
                    <span class="detail-path_folder">
                              <img src="@/assets/img/arrow_right.svg" alt="error-arrow_right">
                            </span>
                    <div class="detail-path_folder">
                        NFT
                    </div>
                </div>
            </li>
            <li class="detail-structure">
                <div class="detail-structure_head">
                    <div class="folder-arrow">
                        <img id="folder-arrow" src="@/assets/img/folder-arrow_right.svg" alt="error-arrow_bottom">
                    </div>
                    <div class="folder-parent">
                        <div class="folder-parent_icon">
                            <img src="@/assets/img/iconFolder.svg" alt="error-iconFolder">
                        </div>
                        <div class="folder-parent_txt">NFT</div>
                    </div>
                </div>
                <div class="detail-structure_content">
                    <div class="folder-arrowRight">
                        <img src="@/assets/img/arrow_right.svg" alt="error-arrow_right">
                    </div>
                    <div class="folder-parent">
                        <div class="folder-parent_icon">
                            <img src="@/assets/img/iconFolder.svg" alt="error-iconFolder">
                        </div>
                        <div class="folder-parent_txt">ERC20</div>
                    </div>
                </div>
                <div class="detail-structure_child">
                    <div class="folder-arrowRight">
                        <img id="folder-arrow" src="@/assets/img/folder-arrow_right.svg" alt="error-arrow_bottom">
                    </div>
                    <div class="folder-parent">
                        <div class="folder-parent_icon">
                            <img src="@/assets/img/iconFolder.svg" alt="error-iconFolder">
                        </div>
                        <div class="folder-parent_txt">ERC721</div>
                    </div>
                </div>
                <div class="detail-structure_pdf">
                    <div class="detail-structure_childHead">
                        <img id="icon-pdf" src="@/assets/img/pdf.svg" alt="error-pdf">
                        <div class="tructure_childHead-number">1</div>
                    </div>

                    <div class="detail-structure_childFirl">
                        <img id="icon-pdf" src="@/assets/img/pdf.svg" alt="error-pdf">
                        <div class="tructure_childHead-number">2</div>
                    </div>
                </div>

            </li>

            <li class="detail-shared">
                <div class="detail-shared_title">Shared with</div>
                <div class="detail-shared_user">
                    <div class="shared_user-icon">
                        <img id="shared-use" src="@/assets/img/Oval.png" alt="error-user">
                    </div>
                    <div class="shared_user-name">Nguyen Cong Thinh <span class="shared_user-txt">(Owner)</span></div>
                </div>
                <div class="detail-shared_user">
                    <div class="shared_user-icon">
                        <img id="shared-use" src="@/assets/img/Oval.png" alt="error-user">
                    </div>
                    <div class="shared_user-name">Nguyen Minh Hien</div>
                </div>
                <div class="detail-shared_user">
                    <div class="shared_user-icon">
                        <img id="shared-use" src="@/assets/img/Oval.png" alt="error-user">
                    </div>
                    <div class="shared_user-name">Pham Van Dam</div>
                </div>
                <div class="detail-shared_user">
                    <div class="shared_user-icon">
                        <img id="shared-use" src="@/assets/img/Oval.png" alt="error-user">
                    </div>
                    <div class="shared_user-name">Kim Si Chun  <span class="shared_user-txt">(You)</span></div>
                </div>
            </li>

        </ul>
    </div>
    
</template>
<script>
export default {
    props: ['drawerVisible'],
    data() {
        return {
            open: false,
            itemDetail: {}
        };
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    methods: {
        btnOfDetail() {
            this.$emit("ClickOffDetail", false)
        }
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

<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";
@import "@/assets/style/_global.scss";


// folder detail

.detail-option {
    display: flex;
    gap: 0 34px;
    padding: 16px;
    border-bottom: 1px solid var(--border-color);
}
.detail-file {
    padding: 16px;
}
.detail-parameter {
    margin-bottom: 16px;
}
.detail-parameter_header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
}
.parameter_header-txt {
    display: flex;
    align-items: center;
    gap: 8px;
}
.parameter_header-txt {
    font-weight: 600;
    font-size: 16px;
    color: var(--text-color--1);
}
.detail-parameter_content {
    background: var(--bgc-active-menu);
    border-radius: 12px;
}
#parameter_content-folder {
    width: 100%;
    height: auto;
    padding: 30px 96px;
}
.detail-Properties {
    margin-bottom: 16px;
    padding-bottom: 8px;
    border-bottom: 1px solid var(--border-color);
}
.detail-Properties-title {
    font-weight: 600;
    font-size: 16px;
    color: var(--text-color--1);
    margin-bottom: 8px;
}
.detail-Properties-txt {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 8px;
}
.Properties-txt {
    font-size: 12px;
    color: var(--text-color-txt);
}
.Properties-file {
    font-weight: 500;
    font-size: 14px;
    color: var(--text-color--1);
}
.detail-description {
    margin-bottom: 16px;
    border-bottom: 1px solid var(--border-color);
}
.detail-description_title {
    font-weight: 600;
    font-size: 16px;
    color: var(--text-color--1);
    margin-bottom: 8px;
}
.detail-description_add {
    font-weight: 500;
    font-size: 14px;
    color: var(--text-color-txt);
    background: var(--bgc-folder--icon);
    padding: 8px;
    border: 1px solid var(--border-color);
    border-radius: 8px;
    margin-bottom: 16px;
}
.detail-path {
    margin-bottom: 16px;
}
.detail-path_title {
    font-weight: 600;
    font-size: 16px;
    color: var(--text-color--1);
    margin-bottom: 8px;
}

.detail-path_txt {
    background: var(--bgc-folder--icon);
    border: 1px solid var(--border-color);
    border-radius: 8px;
    padding: 8px;
    margin-bottom: 16px;
}
.detail-path_txt {
    display: flex;
    align-items: center;
    gap: 0 10px;
    padding: 8px;
}
.detail-path_folder {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color-txt);
}
.detail-structure {
    margin-bottom: 16px;
}
.detail-structure_head {
    display: flex;
    align-items: center;
    gap: 0 9px;
    cursor: pointer;
}
.folder-parent {
    display: flex;
    align-items: center;
    gap: 0 4px;
}
#folder-parent_icon {
    width: 16px;
    height: 16px;
}
.folder-parent_txt {
    font-size: 12px;
    color: var(--text-color-txt);
}
.detail-structure_content {
    display: flex;
    align-items: center;
    margin-top: 8px;
    margin-left: 28px;
    gap: 0 10px;
    cursor: pointer;
}
.folder-parent {
    display: flex;
    align-items: center;
    gap: 0 4px;
}
.detail-structure_child {
    display: flex;
    align-items: center;
    margin-top: 8px;
    margin-left: 26px;
    gap: 0 10px;
    cursor: pointer;
}

.detail-structure_childHead {
    display: flex;
    align-items: center;
    gap: 0 4px;
    margin-top: 8px;
    cursor: pointer;

}
#icon-pdf {
    width: 16px;
    height: 16px;
}
.tructure_childHead-number {
    font-size: 12px;
    line-height: 16px;
    letter-spacing: 0.02em;
    color: var(--text-color-txt);
}
.detail-structure_childFirl {
    display: flex;
    align-items: center;
    gap: 0 4px;
    margin-top: 8px;
    margin-bottom: 16px;
    cursor: pointer;
}
.detail-structure_pdf {
    margin-left: 75px;
}

.detail-shared_user {
    display: flex;
    align-items: center;
    gap: 0 8px;
}
.detail-shared_title {
    font-weight: 600;
    font-size: 16px;
    color: var(--text-color--1);
}

#shared-use {
    width: 16px;
    height: 16px;
}
.shared_user-name {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color--2);
}
.shared_user-txt {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color-txt);
}
#border-dropdown {
    padding: 12px 10px;
    border-bottom: 1px solid var(--border-color);
    border-radius: 500px;
}
.parameter_header-close {
    cursor: pointer;
}
.detail-description_add {
    cursor: pointer;
}

//
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
