<template v-if="authState.isAuthenticated">
    <div class="home" v-cloak>
        <div class="row equal">
            <div class="col-sm-4">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title text-bold">Total documents</h3>
                        <h2 class="card-text">8</h2>
                        <button class="navigate-btn">
                            <span class="material-icons">
                                open_in_new
                            </span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title text-bold">Documents waiting to sign</h3>
                        <h2 class="card-text">3</h2>
                    </div>
                </div>
            </div> 
            <div class="col-sm-4">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title text-bold">Documents signed</h3>
                        <h2 class="card-text">5</h2>
                    </div>
                </div>
            </div> 
        </div>
        <br>
        <div class="row">
            <div class="col">
                <div class="card h-100">
                <div class="card-body">
                <h5 class="card-title">Transactions</h5>
                <div class="table-responsive">
                    <table id="transactionsTable" class="table table-hover" data-pagination="true">
                    <thead>
                    <tr>
                        <th scope="col">Transaction Hash</th>
                        <th scope="col">Age</th>
                        <th scope="col">From</th>
                        <th scope="col">To</th>
                        <th scope="col">TxnFee</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">
                        <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                        </th>
                        <td>40 days 2 hrs ago</td>
                        <td>0x09876c96f802471849..</td>
                        <td>0xb8262489b64477e886..</td>
                        <td>0.00028181 BNB</td>
                    </tr>
                    <tr>
                        <th scope="row">
                        <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                        </th>
                        <td>40 days 2 hrs ago</td>
                        <td>0x09876c96f802471849..</td>
                        <td>0xb8262489b64477e886..</td>
                        <td>0.00028181 BNB</td>
                    </tr>
                    <tr>
                        <th scope="row">
                        <a href="">0xa72f7f450356590670a780fbdd7f4b..</a>
                        </th>
                        <td>40 days 2 hrs ago</td>
                        <td>0x09876c96f802471849..</td>
                        <td>0xb8262489b64477e886..</td>
                        <td>0.00028181 BNB</td>
                    </tr>
                    <tr>
                        <td class="text-center" colspan="5" scope="row"><a href="">See more ...</a></td>
                    </tr>
                    </tbody>
                </table>
                </div>
                </div>
            </div>
            </div> 
        </div>
        <br>
        <Folder/>
    </div>
    
  </template>
<script>
import Folder from '../components/Folder.vue'

export default {
  components: {
    Folder
  }
}
</script>
<style scoped>
  .navigate-btn {
    color: var(--primary);
  }
  .card {
    height: 100%;
  }
</style>