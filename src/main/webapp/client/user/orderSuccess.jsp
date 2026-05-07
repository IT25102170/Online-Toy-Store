<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToyGalaxy | Order Successful</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Outfit', sans-serif; }
        .glass {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.4);
        }
        .neo-button {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            box-shadow: 0 10px 20px -10px rgba(79, 70, 229, 0.5);
        }
        .neo-button:hover {
            box-shadow: 0 15px 25px -5px rgba(79, 70, 229, 0.6);
            transform: translateY(-2px);
        }
        @keyframes success-pop {
            0% { transform: scale(0.5); opacity: 0; }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); opacity: 1; }
        }
        .animate-success { animation: success-pop 0.8s cubic-bezier(0.34, 1.56, 0.64, 1) forwards; }
        
        .star-rating label { cursor: pointer; }
        .star-rating input:checked ~ label i,
        .star-rating label:hover i,
        .star-rating label:hover ~ label i {
            color: #fbbf24;
            text-shadow: 0 0 10px rgba(251, 191, 36, 0.4);
        }
    </style>
</head>
<body class="bg-slate-50 min-h-screen relative overflow-x-hidden">
    <!-- Animated background elements -->
    <div class="fixed top-[-10%] right-[-10%] w-[50%] h-[50%] bg-indigo-200/30 rounded-full blur-[120px] pointer-events-none"></div>
    <div class="fixed bottom-[-10%] left-[-10%] w-[50%] h-[50%] bg-blue-200/30 rounded-full blur-[120px] pointer-events-none"></div>

    <!-- Header -->
    <header class="relative z-50 p-8">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <div class="text-3xl font-black tracking-tighter cursor-pointer" onclick="window.location.href='${pageContext.request.contextPath}/index'">
                Toy<span class="text-indigo-600">Galaxy</span>
            </div>
        </div>
    </header>

    <main class="relative z-10 px-5 pb-24">
        <div class="max-w-3xl mx-auto">
            
            <!-- Success Hero Card -->
            <div class="glass rounded-[3.5rem] p-12 text-center shadow-2xl border border-white/60 mb-12 animate-success">
                <div class="w-32 h-32 bg-indigo-600 text-white rounded-[2.5rem] flex items-center justify-center text-6xl mx-auto mb-8 shadow-2xl shadow-indigo-200 relative">
                    <i class="fas fa-rocket"></i>
                    <div class="absolute -top-2 -right-2 w-8 h-8 bg-emerald-500 rounded-full border-4 border-white flex items-center justify-center text-sm">
                        <i class="fas fa-check"></i>
                    </div>
                </div>
                
                <h1 class="text-5xl font-black text-slate-900 mb-4 tracking-tight">Order Launched!</h1>
                <p class="text-slate-500 text-lg font-medium max-w-md mx-auto mb-10 leading-relaxed">
                    Your journey into fun has begun. We've received your order and are preparing it for departure.
                </p>

                <!-- Order Recap -->
                <div class="bg-white/40 rounded-[2.5rem] p-8 text-left border border-white/60 mb-10">
                    <div class="grid grid-cols-2 gap-y-4 text-sm">
                        <div class="text-slate-400 font-black uppercase tracking-widest text-[10px]">Order ID</div>
                        <div class="text-right text-slate-900 font-bold">#${order.orderId}</div>
                        
                        <div class="text-slate-400 font-black uppercase tracking-widest text-[10px]">Toy Name</div>
                        <div class="text-right text-slate-900 font-bold">${product.productName}</div>
                        
                        <div class="text-slate-400 font-black uppercase tracking-widest text-[10px]">Quantity</div>
                        <div class="text-right text-slate-900 font-bold">${order.quantity}</div>
                        
                        <div class="text-slate-400 font-black uppercase tracking-widest text-[10px]">Total Price</div>
                        <div class="text-right text-indigo-600 font-black text-xl">$${order.totalPrice}</div>
                        
                        <div class="pt-4 border-t border-white/60 col-span-2 flex justify-between items-center">
                            <span class="text-slate-400 font-black uppercase tracking-widest text-[10px]">Status</span>
                            <span class="px-4 py-1.5 bg-emerald-50 text-emerald-600 rounded-full text-[10px] font-black uppercase tracking-widest border border-emerald-100">
                                ${order.status}
                            </span>
                        </div>
                    </div>
                </div>

                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/user/products'" 
                            class="px-8 py-4 bg-white text-indigo-600 rounded-2xl font-black text-sm border-2 border-indigo-50 hover:bg-indigo-50 transition-all active:scale-95">
                        Keep Exploring
                    </button>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/index'" 
                            class="neo-button px-10 py-4 text-white rounded-2xl font-black text-sm transition-all active:scale-95">
                        Return Home
                    </button>
                </div>
            </div>

            <!-- Feedback Section -->
            <div class="glass rounded-[3.5rem] p-12 shadow-2xl border border-white/60">
                <div class="flex flex-col md:flex-row gap-10 items-start">
                    <div class="md:w-1/3">
                        <h2 class="text-3xl font-black text-slate-900 tracking-tight leading-tight mb-4">How was your experience?</h2>
                        <p class="text-slate-500 font-medium text-sm leading-relaxed">
                            Your feedback helps the galaxy grow! Share your thoughts about your new toy.
                        </p>
                    </div>
                    
                    <div class="flex-1 w-full">
                        <form action="${pageContext.request.contextPath}/user/reviews" method="POST" class="space-y-8">
                            <input type="hidden" name="action" value="create">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/user/profile">
                            
                            <div>
                                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4 ml-1">Rate this product</label>
                                <div class="flex gap-4 star-rating justify-between">
                                    <c:forEach var="i" begin="1" end="5">
                                        <div class="relative">
                                            <input type="radio" name="rating" id="star-${i}" value="${i}" required class="sr-only peer">
                                            <label for="star-${i}" class="w-12 h-12 rounded-xl bg-white border border-slate-100 flex items-center justify-center text-slate-300 transition-all hover:scale-110 active:scale-90 peer-checked:bg-indigo-50 peer-checked:border-indigo-600 peer-checked:text-amber-400 shadow-sm hover:shadow-md">
                                                <i class="fas fa-star text-xl"></i>
                                            </label>
                                            <span class="absolute -top-2 -right-2 bg-indigo-600 text-white text-[8px] font-black w-4 h-4 rounded-full opacity-0 peer-checked:opacity-100 transition-opacity flex items-center justify-center">${i}</span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <div>
                                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4 ml-1">Your Review</label>
                                <textarea name="comment" rows="4" required placeholder="What did you think of the product?" 
                                          class="w-full p-5 bg-white border border-slate-100 rounded-3xl focus:ring-4 focus:ring-indigo-100 focus:border-indigo-600 outline-none transition-all font-medium text-slate-700 shadow-inner resize-none"></textarea>
                            </div>

                            <button type="submit" class="neo-button w-full py-5 text-white rounded-2xl font-black text-lg transition-all active:scale-95 group">
                                <span class="flex items-center justify-center">
                                    Post Review
                                    <i class="fas fa-paper-plane ml-3 group-hover:translate-x-2 group-hover:-translate-y-1 transition-transform"></i>
                                </span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="p-12 text-center">
        <p class="text-[10px] font-black text-slate-300 uppercase tracking-[0.3em]">&copy; 2024 ToyGalaxy. All rights reserved.</p>
    </footer>

</body>
</html>
