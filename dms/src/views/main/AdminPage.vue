<template>
    <div>
        <div class="d-flex justify-content-between">
            <div class="p-2">
                <button class="btn btn-primary" type="button" id="createUserBtn" data-toggle="modal" data-target="#modalCreateUser">
                    <i class="mdi mdi-plus text-light"></i> New User
                </button>
            </div>
            <div class="modal fade" id="modalCreateUser" tabindex="-1" role="dialog" aria-labelledby="modalCreateUserTitle" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                  <div class="modal-content">
                      <div class="modal-header">
                          <h5 class="modal-title">New User</h5>
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                          </button>
                      </div>
                      <div class="modal-body">
                          <form>
                              <div class="form-group">
                                  <label for="username">Username</label>
                                  <input v-model="userCreateForm.username" type="text" class="form-control"  placeholder="Username" autofocus>
                              </div>
                              <div class="form-group">
                                  <label for="password">Password</label>
                                  <input v-model="userCreateForm.password" type="password" class="form-control" placeholder="Password">
                              </div>
                              <div class="form-group">
                                  <label for="name">Email</label>
                                  <input v-model="userCreateForm.email" type="text" class="form-control" placeholder="Email">
                              </div>
                              <div class="form-group">
                                  <label for="firstName">First Name</label>
                                  <input v-model="userCreateForm.firstName" type="text" class="form-control" placeholder="First name">
                              </div>
                              <div class="form-group">
                                  <label for="lastName">Last Name</label>
                                  <input v-model="userCreateForm.lastName" type="text" class="form-control" placeholder="Last name">
                              </div>
                              <div class="form-group">
                                  <label for="role">Role</label>
                                  <select v-model="userCreateForm.role" class="custom-select">
                                    <option disabled selected :value="{}">Choose role...</option>
                                    <option v-for="(role, index) in userState.roleList" :key="index" :value="role">{{role.name}}</option>
                                </select>
                              </div>
                              <div v-show="userCreateForm.role.type == 'manager' || userCreateForm.role.type == 'employee'" class="form-group">
                                  <label for="department">Department</label>
                                  <select v-model="userCreateForm.dept" class="custom-select">
                                    <option disabled value="">Choose department...</option>
                                    <option v-for="(dept, index) in userState.deptList" :key="index" :value="dept._id">{{dept.name}}</option>
                                </select>
                              </div>
                          </form>
                      </div>
                      <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                          <button type="button" class="btn btn-primary" @click="handleCreateUser" data-dismiss="modal">Create</button>
                      </div>
                  </div>
              </div>
          </div>
        </div> 
        <div data-app>
          <DataTableVue :headersProps="headers" :itemsProps="adminState.users" />
        </div>
        
          
    </div>
    
</template>

<script setup>
  // import Multiselect from '@vueform/multiselect'
  import DataTableVue from "../../components/DataTable.vue";
</script>
<script>
  export default {
    // components: {Multiselect},
    props: {},
    data() {
      return {
        userCreateForm: {
          username: "",
          password: "",
          email: "",
          firstName: "",
          lastName: "",
          dept: "",
          role: {},
        },
        headers: [
            { text: 'NAME', value: 'name',filter: true },
            { text: 'USERNAME', value: 'username', filter: true },
            { text: 'EMAIL', value: 'email', filter: true },
            { text: 'PUBLIC ADDRESS', value: 'publicAddress', filter: true },
            { text: 'ROLE', value: 'role', filter: true }
        ],
      }
    },
    mounted() {
        this.$router.push(this.$route.path)
        this.callAPI()
    },
    created() {
        this.$store.dispatch("auth/sidebarActive", "admin")      
    },
    methods: {
      async callAPI() {
        await this.$store.dispatch("admin/getAllUsers")
        await this.$store.dispatch("user/getDeptList")
        await this.$store.dispatch("user/getRoleList") 
      },
      handleCreateUser() {
        if(this.userCreateForm.role.type == 'bod' || this.userCreateForm.role.type == 'chairperson') {
          this.userCreateForm.dept = null
        }
          let data = Object.assign({},{role: this.userCreateForm.role._id, ...this.userCreateForm})
          this.$store.dispatch("admin/createUser", data)
      },
      
    },
    computed: {
      adminState() {return this.$store.state.admin},
      userState() {return this.$store.state.user}
    }
  }
</script>
<style scoped>
.data-table {
  width: 80%;
}
</style>