<template>
    <div class="modal fade" id="modalCreateFolder" tabindex="-1" role="dialog" aria-labelledby="modalCreateFolderTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">New Folder</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form v-on:submit.prevent="">
                        <div class="form-group">
                            <label for="name">Folder Name</label>
                            <input v-on:keyup.enter="handleCreateFolder" v-model="name" type="text" class="form-control" id="newFolderName" placeholder="Folder name" autofocus>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" @click="handleCreateFolder" data-dismiss="modal">Create</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import $ from "jquery"
export default {
    props: {
        parentId: String,
    },
      mounted() {
          
      },
      created() {
              
      },
      data() {
          return {
              name: "Untitled Folder",
          }
      },
      computed: {
          documentState() {return this.$store.state.document },
      },
      methods: {
        handleCreateFolder() {
            if(!this.name) {
                alert("Please provide a folder name")
                return;
            }
            let data = {
                parentId: this.parentId,
                name: this.name
            }
            this.$store.dispatch("document/createFolder", data)
            $('#modalCreateFolder').modal('hide')
        }
      },
    }
  </script>