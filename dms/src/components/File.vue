<template>
    <div>
        <div @click="openModal(id)" class="tile file">
            <span class="file-icon">
                <i v-if="fileType=='application/pdf'" class="mdi mdi-file-pdf-box text-danger"></i>
                <i v-else-if="fileType=='application/vnd.ms-powerpoint'" class="mdi mdi-microsoft-powerpoint text-danger"></i>
                <i v-else-if="fileType=='application/vnd.openxmlformats-officedocument.presentationml.presentation'" class="mdi mdi-microsoft-powerpoint text-danger"></i>
                <i v-else-if="fileType=='application/msword'" class="mdi mdi-microsoft-word text-primary"></i>
                <i v-else-if="fileType=='application/vnd.openxmlformats-officedocument.wordprocessingml.document'" class="mdi mdi-microsoft-word text-primary"></i>
                <i v-else-if="fileType=='application/vnd.ms-excel'" class="mdi mdi-microsoft-excel text-success"></i>
                <i v-else-if="fileType=='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'" class="mdi mdi-microsoft-excel text-success"></i>
                <i v-else-if="fileType=='text/javascript'" class="mdi mdi-language-javascript text-warning"></i>
                <i v-else-if="fileType=='text/x-java-source'" class="mdi mdi-language-java text-danger"></i>
                <i v-else-if="fileType=='text/html'" class="mdi mdi-language-html5 text-warning"></i>
                <i v-else-if="fileType=='text/css'" class="mdi mdi-language-css3 text-primary"></i>
                <i v-else class="mdi mdi-file text-secondary"></i>
            </span>
        <h5 class="truncate">{{name}}</h5>
        </div>
    </div>
</template>
<script>
import $ from 'jquery' 
export default {
    props: {
        id: String,
        fileType: String,
        name: String,
        file: Object
    },
   methods: {
    openModal() {
        $("#"+this.id).modal('toggle');
    }
   },
    mounted() {
        
    }
}

</script>

<style scoped>
.tile {
    border-radius: 3px;
    width: 200px;
    height: 100%;
    margin-bottom: 23px;
    text-align: center;
    border: 1px solid #eeeeee;
    transition: 0.2s all cubic-bezier(0.4, 0.0, 0.2, 1);
    position: relative;
    padding: 35px 16px 25px;
    margin-right: 17px;
    cursor: pointer;
}
.tile:hover{
  box-shadow: 0px 7px 5px -6px rgba(0, 0, 0, 0.12);
  background-color: #eeeeee;
  border: 1px solid #dddddd;
}
.tile .material-icons{
    color: #00A8FF;
    height: 55px;
    margin-bottom: 20px;
    font-size: 55px;
    display: block;
    line-height: 54px;
    cursor: pointer;
}
.file-icon {
    color: #00A8FF;
    height: 55px;
    margin-bottom: 20px;
    font-size: 55px;
    display: block;
    line-height: 54px;
    cursor: pointer;
}
.truncate {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis; 
}
</style>