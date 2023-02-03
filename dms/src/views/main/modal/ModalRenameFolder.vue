<template>
    <div :id="'rename-'+folder._id">
        <div class="modal-mask" id="exampleModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-wrapper" @click="handleCloseModal">
                <div class="modal-container" role="document" @click.stop="">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Rename</h5>
                        <button type="button" class="close" @click="handleCloseModal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form v-on:submit.prevent="">
                            <div class="form-group">
                                <label for="name">Folder Name</label>
                                <input id="folderName" v-on:keyup.enter="handleRenameFolder" v-model="name" type="text" class="form-control" placeholder="Folder name" autofocus>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" @click="handleCloseModal">Close</button>
                        <button type="button" class="btn btn-primary" @click="handleRenameFolder">Save changes</button>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
import $ from 'jquery'
</script>
<script>
export default {
    props: ['folderProps'],
    data() {
        return{
            folder: {},
            name: ''
        }
    },
    methods: {
        handleCloseModal() {
            this.isOpen = false
            this.$emit('handleCloseModal')
        },
        handleRenameFolder() {
            if(!this.name) {
                alert("Folder name is not valid")
                return
            }
            if(this.name == this.folderProps.name) {
                this.handleCloseModal()
            }else {
                console.log("new name", this.name);
                let data = {
                    folderId: this.folderProps._id,
                    name: this.name
                }
                this.$store.dispatch("document/editFolder", {type: 'rename', data})
                this.handleCloseModal()
            }
            
        }
    },
    mounted() {
        $('#folderName').trigger('focus');
        $('#folderName').select()
    },
    watch: {
        'folderProps' : {
            handler(newVal, oldVal) {
                console.log(newVal);
                if(newVal !== oldVal) {
                    this.folder = newVal
                    this.name = this.folderProps.name
                }
            },
            immediate: true
        }
    }
}
</script>
<style scoped>
.modal-mask {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, .5);
    display: table;
    transition: opacity .3s ease;
    z-index: 1;
}
.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
} 
.modal-container {
  width: 30%;
  margin: 0px auto;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
</style>