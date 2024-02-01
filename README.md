# Flask-based e-commerce for digital products

### Overview

The system is designed to be an online shopping platform that can provide a wide range of users.
Users can create an account using their email address, which cannot be duplicated.
Once registered, they can log in to their account and modify their password as needed.
They can place orders for products, add items to their wish list for future purchase, and offer a contact phone number for customer service. The shopping experience can be enhanced by a search bar that allows users to easily find the products they’re looking for.
A shopping cart is also available for users to manage their selected items before checkout.
The system also provides a variety of product categories for users to browse through.
Each category page displays 12 items per page.
Products are also sorted into different sections based on their popularity (Hot Products), time of addition (New Arrivals), and discounts.
Administrators have access to a separate back end management system.
They can manage products, view sales rankings, member information(including username, phone, email, and consumption), and manage orders (including order number, Consignees, phone, address, and order date).
They also have the ability to add or delete categories and products, providing a dynamic and flexible inventory management solution.
Moreover, administrators can query the product information, sales volume, etc., and can also understand the product situation more intuitively through more visual pie charts.
In conclusion, the system is designed to provide a comprehensive and user- friendly online shopping experience for its users, while also providing administrators with the tools they need to effectively manage the platform. The system can meet the diverse needs of both users and administrators.

### Front-end Design

This section will contain a description of the front-end design and the connection from the front-end to the back-end.
The front-end design of this project needs to implement an e-commerce website, and we choose to implement a Digital shopping website that mainly sells electronic products.
The target users of the project will be the visitors and users of the website. The website allows them to browse/order/favorite and other operations. We try to create a beautiful interactive system.
In terms of front-end design technology, this project mainly uses Html+css+javascript technology for implementation, and the back-end development technology chooses to use the Flask framework to build the project and implement the connection between the front-end and the back-end.

### Front-end and back-end connection steps

#### Create a back-end API endpoint:

In the Flask application, create a route and corresponding view function to handle front-end requests. All back-end logic processing based on the front-end interface of our customer interface and administrator interface is completed in the respective views.py of the front-end and front-end. For registered users, password changes and other requirements, we perform them in forms.py.

#### Asynchronous communication using AJAX:

Use JavaScript's AJAX technology on the front end to send HTTP requests to the back-end API endpoint through the XMLHttpRequest object or the Fetch API. This allows communication with the back-end without refreshing the entire page.

#### Handle back-end response:

Set a callback function on the frontend to handle the data received from the back-end. This may involve updating page elements, displaying error messages, etc.

#### Using JSON for data transmission:

The back-end sends data to the frontend through JSON format. The front end uses this information by parsing the JSON data.

#### Update page elements:

After receiving back-end data, use JavaScript to update page elements, such as updating product lists, displaying user information, etc.

#### Testing and debugging:

Throughout the connection process, perform testing and debugging to ensure that communication between the front and back ends is reliable and that the application functions properly in different environments.

### Part of the page and function show

![Front Homepage](/Show/1.png)

![Login page](/Show/2.png)

![Register page](/Show/3.png)

![Product Details](/Show/4.png)

![Different Products](/Show/5.png)

![Cart](/Show/6.png)

![Orders](/Show/7.png)

![Back Homepage](/Show/8.png)

![Back Stage Login](/Show/9.png)
