<template>
    <div :id="'share-'+folder._id">
        <div class="modal-mask" id="exampleModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-wrapper" @click="handleCloseModal">
                <div class="modal-container" role="document" @click.stop="">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Share folder "{{ folder.name }}"</h5>
                        <button type="button" class="close" @click="handleCloseModal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <treeselect
                            :multiple="true"
                            :options="options"
                            :value-consists-of="valueConsistsOf"
                            v-model="value"
                            :normalizer="normalizer"
                            />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" @click="handleCloseModal">Close</button>
                        <button v-if="value" type="button" class="btn btn-primary" @click="handleShareFolder">Share</button>
                        <button v-else type="button" class="btn btn-primary" disabled>Share</button>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import $ from 'jquery'
import { ASYNC_SEARCH } from '@riophae/vue-treeselect'
import Treeselect from '@riophae/vue-treeselect'

export default {
    props: ['folderProps'],
    components: { Treeselect },
    data() {
      return{
        folder: {},
        name: '',
        value: null,
        valueConsistsOf: 'LEAF_PRIORITY',
        options: [],
        normalizer(node) {
            return {
                id: node._id,
                label: node.name,
                children: node.children,
            }
        },
      }
    },
    mounted() {
        $('#newFolderName').trigger('focus');
        $('#newFolderName').select()
        this.initData()
    },
    methods: {
        handleCloseModal() {
            this.isOpen = false
            this.$emit('handleCloseModal')
        },
        handleRenameFolder() {
            console.log("new name", name);
        },
        handleShareFolder() {
            if(!this.value.length) {
                this.$emit('handleCloseModal')
                return
            }
            this.$swal({
                title: 'Are you sure sharing this folder?',
                text: `Anyone in this list can view all files and folders in "${this.folder.name}" !`,
                icon: 'info',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Share'
                }).then((result) => {
                if (result.isConfirmed) {
                    let data = {
                        folderId: this.folder._id,
                        sharedList: this.value
                    }
                    this.$store.dispatch("document/editFolder", {type: 'share', data})
                    console.log(this.value);
                }
            });
            
        },
        async initData() {
          if(!this.userState.treeUser) {
            await this.$store.dispatch("user/getTreeUser")
          }
          this.options = this.userState.treeUser
        }
    },
    computed: {
      userState() {return this.$store.state.user },
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