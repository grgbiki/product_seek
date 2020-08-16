<template>
	<div class="row">
	<loader v-if='loading'></loader>
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="row">
					<button class="btn btn-primary mr-1" @click='openModel'>
						<i class="fas fa-plus mr-1"></i>Create Store
					</button>
					<a :href="store_url+'/trashed'">
						<button class="btn btn-danger ">
							<i class="fas fa-trash mr-1"></i>Trash
						</button>
					</a>
				</div>
			</div>

			<div class="card mt-2">
				<div class="card-header">
					<h4>Stores</h4>
				</div>
				<div class="card-bodytable-responsive p-0">
					<table class="table table-hover text-nowrap">
            <thead>
              <tr>
                <th>Name</th>
                <th>No of Products</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
            	<tr v-if='!storesLength'>
            		<td colspan="5">Sorry! no data found</td>
            	</tr>
            	<tr v-else v-for='pc in stores.data' :key='pc.id'>
            		<td>{{ pc.name }}</td>
            		<td>0</td>
            		<td>{{ pc.email }}</td>
            		<td>{{ pc.contact }}</td>
            		<td>
            			<button class="btn btn-primary mr-2" @click='editStore(pc.id)'><i class="fas fa-edit mr-2"></i>Edit</button>
            			<button class="btn btn-danger" @click='trashStore(pc.id)'><i class="fas fa-trash mr-2"></i>Trash</button>
            		</td>
            	</tr>
            </tbody>
             <tfoot>
		            <tr>
                	<th>Name</th>
	                <th>No of Products</th>
	                <th>Email</th>
	                <th>Contact</th>
	                <th>Action</th>
	              </tr>
		          </tfoot>
          </table>
				</div>
				<div class="card-footer">
					<pagination :data="stores" @pagination-change-page="getResults"></pagination>
				</div>
			</div>

			<div class="modal fade" id="storeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<h5 class="modal-title" v-if='editmode'id="exampleModalLongTitle">Edit Store</h5>
			        <h5 class="modal-title" v-else id="exampleModalLongTitle">Create Store</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <form @submit.prevent="editmode? updateStore() : createStore()">
				      <div class="modal-body">
				        <div class="form-group">
				        	<label for="name">Store's name</label>
			        		<input v-model="form.name" type="text" name="name" class="form-control" :class="{ 'is-invalid': form.errors.has('name') }" placeholder="Store's Name">
					      <has-error :form="form" field="name"></has-error>
				        </div>
				         <div class="form-group">
				        	<label for="email">Email</label>
			        		<input v-model="form.email" type="email" name="email" class="form-control" :class="{ 'is-invalid': form.errors.has('email') }" placeholder="Email">
					      <has-error :form="form" field="name"></has-error>
				        </div>
			          <div class="form-group">
				        	<label for="contact">Contact</label>
			        		<input v-model="form.contact" type="tel" name="contact" class="form-control" :class="{ 'is-invalid': form.errors.has('contact') }" placeholder="Contact">
					      <has-error :form="form" field="contact"></has-error>
				        </div>
				        <div class="form-group">
				        	<label for="address">Address</label>
			        		<input v-model="form.address" type="text" name="address" class="form-control" :class="{ 'is-invalid': form.errors.has('address') }" placeholder="Address">
					      <has-error :form="form" field="contact"></has-error>
				        </div>
				         <div class="form-group">
				        	<label for="google_maps_url">Google Map Url</label>
			        		<input v-model="form.google_maps_url" type="url" name="google_maps_url" class="form-control" :class="{ 'is-invalid': form.errors.has('google_maps_url') }" placeholder="Google Map Url">
					      <has-error :form="form" field="google_maps_url"></has-error>
				        </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancle</button>
				        <button type="submit" class="btn btn-primary" v-if='editmode'>Update</button>
				        <button type="submit" class="btn btn-primary" v-else>Create</button>
				      </div>
				    </form>
			    </div>
			  </div>
			</div>

		</div>
		
	</div>
</template>
<script>
	export default{
		name:'store',
		props:['store_url'],
		data(){
			return{

				form:new Form({
					id:'',
					name:'',
					email:'',
					contact:'',
					address:'',
					google_maps_url:'',
				}),

				stores:{},
				storesLength:null,
				editmode:false,
				loading:true,
				
			}
		},
		methods:{
			openModel(){
				this.editmode=false
				this.form.clear()
				this.form.reset()
				$('#storeModal').modal('show')
			},
			createStore(){
				this.loading=true
				this.form.post(this.store_url+'/store/').then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Store Created successfully'
          })
          this.loadStore()
					$('#storeModal').modal('hide')
          this.loading=false;

				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},

			getResults(page = 1) {
        this.loading=true;
        axios.get(this.store_url+'/cat-paginated/?page=' + page)
        .then(response => {
            this.stores = response.data;
            this.loading=false;
        });
      },

			loadStore(){
				axios.get(this.store_url+'/store-paginated/').then(({data})=>{
					this.stores=data
					this.storesLength=this.stores.data.length
					this.loading=false
				})
			},

			editStore(id){
				this.loading=true
				this.editmode=true
				let vm=this;
				axios.get(this.store_url+'/show/'+id).then(function(response){
					vm.form.fill(response.data)
					$('#storeModal').modal('show')
					vm.loading=false
				})
			},

			updateStore(){
				this.loading=true
				this.form.put(this.store_url+'/update/'+this.form.id).then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Store updated successfully'
          })
          this.loadStore()
					$('#storeModal').modal('hide')
          this.loading=false;

				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},

			trashStore(id){
				this.loading=true
				this.form.get(this.store_url+'/trash/'+id).then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Store moved to trash Successfully'
          })
          this.loadStore()
					$('#storeModal').modal('hide')
          this.loading=false;

				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},
		},
		created(){
			this.loadStore()
		}
	}
</script>