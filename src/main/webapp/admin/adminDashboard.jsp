
<%@ include file="./partials/adminHeader.jsp"%>

    <!-- Main Content -->
    <main class="flex-1 p-6">
        <header class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold">Welcome, <%= adminName %> !</h1>
            <button class="md:hidden bg-gray-700 p-2 rounded text-sm">☰</button>
        </header>

        <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div class="bg-gray-700 p-6 rounded-xl shadow hover:shadow-xl transition">
                <h3 class="text-lg font-semibold mb-2">Total Users</h3>
                <p class="text-3xl font-bold">1245</p>
            </div>
            <div class="bg-gray-700 p-6 rounded-xl shadow hover:shadow-xl transition">
                <h3 class="text-lg font-semibold mb-2">Pending Products</h3>
                <p class="text-3xl font-bold">34</p>
            </div>
            <div class="bg-gray-700 p-6 rounded-xl shadow hover:shadow-xl transition">
                <h3 class="text-lg font-semibold mb-2">Monthly Sales</h3>
                <p class="text-3xl font-bold">$8,420</p>
            </div>
        </section>

<%@ include file="./partials/adminFooter.jsp"%>