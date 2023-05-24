<template>
    <div class="folder-list--item">
        <div class="list-folder-item">
            <div class="folder-item_header">
                <img src="@/assets/img/iconFolder.svg" alt="error-iconFolder">
                <div class="folder-item_title">{{folder.name}}</div>
            </div>
            <div class="folder-item_txt">
                <div class="folder-item_file">25 files</div>
                <div class="folder-item_distance"></div>
                <div class="folder-item_MB">50 MB</div>
            </div>
            <div class="folder-item-icon">
                <div class="item-icon_number">
                    <img id="icon-member" src="@/assets/img/Oval.png" alt="error-iconUse">
                    <img id="icon-member" src="@/assets/img/Oval.png" alt="error-iconUse">
                    <img id="icon-member" src="@/assets/img/Oval.png" alt="error-iconUse">
                </div>
                <div class="item-icon_member">+8 member</div>
            </div>
        </div>

    </div>

</template>
<script>

import FolderDetail from "@/components/FolderDetail.vue";

export default {
    components: {FolderDetail},
  props: {
    folder: Object,
  },
  data() {
    return {
    }
  },

  methods: {
    handleAccessFolder() {
        this.$router.push('/folder/' + this.folder._id )
    },
  },
  computed: {
    authState() { return this.$store.state.auth; },
  },
}
</script>
<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";
.folder-list--item {
    cursor: pointer;
}
.list-folder-item {
}
.folder-item_title {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color--1);
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    -webkit-line-clamp: 1;
}
.folder-item_header {
    display: flex;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 4px;
}
.folder-item_txt {
    display: flex;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 8px;
}
.folder-item_file {
    font-size: 12px;
    color: var(--text-color-txt);
}
.folder-item_distance {
    width: 4px;
    height: 4px;
    background-color: var(--text-color-txt);
    border-radius: 50%;
}
.folder-item_MB {
    font-weight: 400;
    font-size: 12px;
    color: var(--text-color-txt);
}
.item-icon_number {
}
.item-icon_member {
    font-size: 12px;
    color: var(--text-color-txt);
}

#icon-member {
    z-index: 1;
    width: 24px;
    height: 24px;
    border: 1.5px solid var(--backgroud);
    border-radius: 50%;
}
#icon-member:nth-child(2) {
    margin-left: -10px;
    z-index: 2;
    border: 1.5px solid var(--backgroud);
    border-radius: 50%;
}
#icon-member:nth-child(3) {
    margin-left: -10px;
    border-radius: 50%;
    border: 1.5px solid var(--backgroud);
    z-index: 3;
}
.folder-item-icon {
    display: flex;
    align-items: center;
    gap: 0 8px;
}

.folder-bottom {
    display: flex;
    justify-content: center;
    align-items: center;
}

.border-dropdown {
    padding: 10px 15px;
    border-radius: 50%;
    border: 1.5px solid var(--border-color);
    cursor: pointer;
}

.folder-item {
    display: flex;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 4px;
}

.truncate {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.material-icons{
    color: #00A8FF;
    height: 55px;
    margin-bottom: 20px;
    font-size: 55px;
    display: block;
    line-height: 54px;
    cursor: pointer;
}
</style>