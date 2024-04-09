import wixUsers from 'wix-users';
import wixData from 'wix-data';
import wixLocation from 'wix-location';

$w.onReady(function () {

	// Write your Javascript code here using the Velo framework API

	// Print hello world:
	// console.log("Hello world!");

	// Call functions on page elements, e.g.:
	// $w("#button1").label = "Click me!";

	// Click "Run", or Preview your site, to execute your code

});

export function submit_click(event) {
	$w("#generalErrMsg").collapse(); 

	let email = $w("#email").value;
 	let password = $w("#password").value;

	wixUsers.login(email, password)
   .then( () => {
     console.log("User is logged in");
	let user = wixUsers.currentUser;
	let userId = user.id;
	let isLoggedIn = user.loggedIn; 
	let userRole = user.role; 


			//search Members database
		wixData.query("Members/PrivateMembersData")
		.eq("_id", userId)
		.find()
		.then((results) => {
			let name = results.items[0].firstName;
			let last = results.items[0].lastName;
			let items = results.items
			let item = items[0]
			if (results.items.length > 0) {  
				//redirects to member page
				console.log("Member Found", item.slug)
			wixLocation.to(`/members-area/${item.slug}/my-account`);
													
				} else {
				//search Members database
									wixData.query("Members/PrivateMembersData")
									.eq("_id", userId)
									.find()
									.then((results) => {
										let items = results.items
										let item = items[0]
					if (results.items.length > 0) {  
						//redirects to member page
						console.log("Found");
					wixLocation.to(`/members-area/${item.slug}/my-account`);
													}
									})   	
				}
				});

   
   } )
		.catch( (err) => {
		console.log(err);
		$w("#generalErrMsg").expand(); 
		$w("#submit").enable();  
	} ); 
	
	
}

export function checkvalues(){

	let email = $w("#email").value;
 	let password = $w("#password").value;

	if(email && password){

		 $w("#submit").enable()

	}

}

export function email_change(event) {
	checkvalues()
}

export function password_change(event) {

	checkvalues()
}
