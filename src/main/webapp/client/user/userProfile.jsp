<%@ page import="model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<main class="min-h-screen pt-24 pb-12 px-5 bg-gradient-to-br from-indigo-50 via-white to-purple-50">
    <div class="max-w-5xl mx-auto">
        
        <!-- Profile Header Card -->
        <div class="bg-white rounded-[3rem] shadow-2xl overflow-hidden border border-white/20 backdrop-blur-xl mb-12">
            <div class="h-48 bg-gradient-to-r from-indigo-600 to-purple-600 relative">
                <div class="absolute -bottom-16 left-12">
                    <div class="w-32 h-32 bg-white rounded-full p-2 shadow-2xl">
                        <div class="w-full h-full bg-indigo-100 rounded-full flex items-center justify-center text-indigo-600 text-4xl font-black">
                            ${user.name.substring(0,1).toUpperCase()}
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="pt-20 pb-10 px-12">
                <div class="flex justify-between items-start">
                    <div>
                        <h1 class="text-4xl font-black text-gray-900">${user.name}</h1>
                        <p class="text-gray-500 font-medium flex items-center mt-1">
                            <i class="fas fa-envelope mr-2 text-indigo-400"></i> ${user.email}
                        </p>
                    </div>
                    <div class="flex space-x-3">
                        <button onclick="toggleEdit()" class="px-6 py-3 bg-indigo-600 text-white rounded-2xl font-bold hover:bg-indigo-700 transition-all shadow-lg hover:-translate-y-1">
                            Edit Profile
                        </button>
                        <form method="post" action="${pageContext.request.contextPath}/user/profile" onsubmit="return confirm('Are you sure? This cannot be undone.')">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="px-6 py-3 bg-red-50 text-red-600 border border-red-100 rounded-2xl font-bold hover:bg-red-100 transition-all">
                                Delete Account
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Profile Stats/Info -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mt-12 pt-8 border-t border-gray-100">
                    <div class="p-6 bg-gray-50 rounded-3xl">
                        <span class="text-gray-400 text-sm font-bold uppercase tracking-wider">Address</span>
                        <p class="text-gray-800 font-semibold mt-1">${user.address != null && !user.address.isEmpty() ? user.address : 'Not provided'}</p>
                    </div>
                    <div class="p-6 bg-gray-50 rounded-3xl">
                        <span class="text-gray-400 text-sm font-bold uppercase tracking-wider">Phone</span>
                        <p class="text-gray-800 font-semibold mt-1">${user.phone != null && !user.phone.isEmpty() ? user.phone : 'Not provided'}</p>
                    </div>
                    <div class="p-6 bg-indigo-50 rounded-3xl">
                        <span class="text-indigo-400 text-sm font-bold uppercase tracking-wider">Total Reviews</span>
                        <p class="text-indigo-600 font-black text-2xl mt-1">${reviews.size()}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Form (Hidden by default) -->
        <div id="profileEditForm" class="hidden fixed inset-0 bg-black/60 backdrop-blur-sm z-[2000] flex items-center justify-center p-5">
            <div class="bg-white rounded-[2.5rem] shadow-2xl w-full max-w-2xl p-10 relative">
                <button onclick="toggleEdit()" class="absolute top-8 right-8 text-gray-400 hover:text-gray-600">
                    <i class="fas fa-times text-xl"></i>
                </button>
                <h2 class="text-3xl font-black text-gray-900 mb-8">Update Your Profile</h2>
                
                <form method="post" action="${pageContext.request.contextPath}/user/profile" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <input type="hidden" name="action" value="update">
                    <div class="space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">Full Name</label>
                        <input type="text" name="name" value="${user.name}" required class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">Email Address</label>
                        <input type="email" name="email" value="${user.email}" required class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">Phone Number</label>
                        <input type="text" name="phone" value="${user.phone}" class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">New Password</label>
                        <input type="password" name="password" placeholder="Leave blank to keep same" class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                    </div>
                    <div class="md:col-span-2 space-y-2">
                        <label class="text-sm font-bold text-gray-700 ml-1">Home Address</label>
                        <textarea name="address" rows="3" class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">${user.address}</textarea>
                    </div>
                    <div class="md:col-span-2 pt-4">
                        <button type="submit" class="w-full py-4 bg-indigo-600 text-white rounded-2xl font-bold text-lg shadow-lg hover:bg-indigo-700 transition-all">
                            Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- My Reviews Section -->
        <div class="mt-16">
            <div class="flex justify-between items-end mb-8">
                <div>
                    <h2 class="text-4xl font-black text-gray-900">My Reviews</h2>
                    <p class="text-gray-500 font-medium mt-2">Manage your feedback on products you've purchased</p>
                </div>
            </div>

            <div class="grid grid-cols-1 gap-6">
                <c:forEach items="${reviews}" var="review">
                    <div class="bg-white rounded-3xl p-8 shadow-xl border border-gray-50 flex items-start space-x-6 hover:shadow-2xl transition-all group">
                        <div class="w-20 h-20 bg-indigo-50 rounded-2xl flex items-center justify-center text-indigo-600 text-3xl font-black flex-shrink-0">
                            ${review.rating}★
                        </div>
                        <div class="flex-1">
                            <div class="flex justify-between">
                                <h3 class="text-xl font-bold text-gray-800">
                                    <c:set var="p" value="${productService.getProductById(review.productId)}"/>
                                    ${p != null ? p.productName : 'Product #'.concat(review.productId)}
                                </h3>
                                <div class="flex space-x-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                    <button onclick="editReview(${review.reviewId}, ${review.rating}, '${review.comment}')" class="p-2 text-indigo-600 hover:bg-indigo-50 rounded-lg transition-colors">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/user/reviews" method="POST" onsubmit="return confirm('Delete this review?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${review.reviewId}">
                                        <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/user/profile">
                                        <button type="submit" class="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-colors">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <p class="text-gray-600 mt-2 leading-relaxed italic">"${review.comment}"</p>
                            <p class="text-gray-400 text-xs font-bold mt-4 uppercase tracking-tighter">Posted on: ${review.createdAt}</p>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty reviews}">
                    <div class="bg-white rounded-3xl p-12 shadow-xl border border-dashed border-gray-200 text-center">
                        <div class="w-20 h-20 bg-gray-50 rounded-full flex items-center justify-center mx-auto mb-6 text-gray-300 text-3xl">
                            <i class="fas fa-comment-slash"></i>
                        </div>
                        <h3 class="text-xl font-bold text-gray-800">No reviews yet</h3>
                        <p class="text-gray-500 mt-2">Your feedback will appear here once you've reviewed some products.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Review Edit Modal -->
    <div id="reviewEditModal" class="hidden fixed inset-0 bg-black/60 backdrop-blur-sm z-[2000] flex items-center justify-center p-5">
        <div class="bg-white rounded-3xl shadow-2xl w-full max-w-lg p-10 relative">
            <button onclick="document.getElementById('reviewEditModal').classList.add('hidden')" class="absolute top-8 right-8 text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
            <h2 class="text-3xl font-black text-gray-900 mb-8">Edit Your Review</h2>
            
            <form action="${pageContext.request.contextPath}/user/reviews" method="POST" class="space-y-6">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="editReviewId">
                <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/user/profile">
                
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Rating</label>
                    <div class="flex space-x-4">
                        <c:forEach var="i" begin="1" end="5">
                            <label class="flex-1">
                                <input type="radio" name="rating" value="${i}" id="rating${i}" class="sr-only peer">
                                <div class="p-3 text-center border-2 border-gray-100 rounded-xl cursor-pointer peer-checked:border-indigo-600 peer-checked:bg-indigo-50 peer-checked:text-indigo-600 font-bold transition-all hover:bg-gray-50">
                                    ${i}★
                                </div>
                            </label>
                        </c:forEach>
                    </div>
                </div>
                
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Comment</label>
                    <textarea name="comment" id="editComment" rows="4" required class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all"></textarea>
                </div>
                
                <button type="submit" class="w-full py-4 bg-indigo-600 text-white rounded-2xl font-bold text-lg shadow-lg hover:bg-indigo-700 transition-all">
                    Update Review
                </button>
            </form>
        </div>
    </div>
</main>

<%@ include file="../partials/UserFooter.jsp" %>

<script>
    function toggleEdit() {
        const form = document.getElementById("profileEditForm");
        form.classList.toggle("hidden");
    }

    function editReview(id, rating, comment) {
        document.getElementById('editReviewId').value = id;
        document.getElementById('editComment').value = comment;
        document.getElementById('rating' + rating).checked = true;
        document.getElementById('reviewEditModal').classList.remove('hidden');
    }
</script>
