<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<!-- Custom Modern Fonts & Animations -->
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Outfit', sans-serif; }
    .glass {
        background: rgba(255, 255, 255, 0.7);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.4);
    }
    .card-glow:hover {
        box-shadow: 0 0 30px rgba(79, 70, 229, 0.15);
    }
    .neo-button {
        background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
        box-shadow: 0 10px 20px -10px rgba(79, 70, 229, 0.5);
    }
    .neo-button:hover {
        box-shadow: 0 15px 25px -5px rgba(79, 70, 229, 0.6);
        transform: translateY(-2px);
    }
    @keyframes float {
        0% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
        100% { transform: translateY(0px); }
    }
    .animate-float { animation: float 6s ease-in-out infinite; }
</style>

<main class="flex-1 min-h-screen p-8 bg-slate-50 relative overflow-hidden">
    <!-- Decorative background elements -->
    <div class="absolute top-[-10%] right-[-10%] w-[40%] h-[40%] bg-indigo-200/30 rounded-full blur-[120px] pointer-events-none"></div>
    <div class="absolute bottom-[-10%] left-[-10%] w-[40%] h-[40%] bg-blue-200/30 rounded-full blur-[120px] pointer-events-none"></div>

    <div class="max-w-6xl mx-auto relative z-10">
        <!-- Breadcrumbs -->
        <nav class="flex mb-8 text-sm font-medium text-gray-400">
            <span class="hover:text-indigo-600 transition-colors cursor-pointer">Marketplace</span>
            <span class="mx-2">/</span>
            <span class="hover:text-indigo-600 transition-colors cursor-pointer">${product.productName}</span>
            <span class="mx-2 text-indigo-600">/</span>
            <span class="text-indigo-600 font-bold tracking-tight">Checkout</span>
        </nav>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12">
            <!-- Left Side: Order & Payment (8 cols) -->
            <div class="lg:col-span-8 space-y-8">
                
                <!-- Section 1: Order Recap -->
                <section class="glass rounded-[2.5rem] p-8 shadow-2xl transition-all hover:shadow-indigo-500/5">
                    <div class="flex items-center justify-between mb-8">
                        <h2 class="text-3xl font-black text-slate-900 tracking-tight flex items-center">
                            <span class="bg-indigo-600 text-white w-10 h-10 rounded-2xl flex items-center justify-center mr-4 text-lg shadow-lg shadow-indigo-200">1</span>
                            Review Items
                        </h2>
                        <span class="px-4 py-2 bg-indigo-50 text-indigo-600 rounded-xl text-xs font-black uppercase tracking-widest">
                            Secure Checkout
                        </span>
                    </div>

                    <div class="group relative flex flex-col md:flex-row items-center gap-8 p-6 bg-white/40 rounded-[2rem] border border-white/60 transition-all hover:bg-white/60">
                        <div class="relative w-40 h-40 shrink-0">
                            <div class="absolute inset-0 bg-indigo-100 rounded-[1.5rem] rotate-3 group-hover:rotate-6 transition-transform"></div>
                            <img src="${product.imageUrl != null ? product.imageUrl : (pageContext.request.contextPath.concat('/client/images/placeholder.png'))}" 
                                 alt="${product.productName}" 
                                 class="relative w-full h-full object-contain rounded-[1.5rem] bg-white p-4 shadow-sm border border-white/20 transition-transform group-hover:-translate-y-2 group-hover:-rotate-3">
                        </div>
                        <div class="flex-1 text-center md:text-left">
                            <h3 class="text-2xl font-extrabold text-slate-800 mb-2">${product.productName}</h3>
                            <div class="flex flex-wrap items-center justify-center md:justify-start gap-4 text-sm text-slate-500 font-medium">
                                <span class="flex items-center"><i class="fas fa-layer-group mr-2 text-indigo-400"></i> Quantity: <b class="text-slate-900 ml-1">${quantity}</b></span>
                                <span class="flex items-center"><i class="fas fa-tag mr-2 text-indigo-400"></i> Unit Price: <b class="text-slate-900 ml-1">$${product.price}</b></span>
                            </div>
                        </div>
                        <div class="text-right">
                            <p class="text-3xl font-black text-indigo-600 leading-none">$${product.price * quantity}</p>
                            <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest mt-2">Total for item</p>
                        </div>
                    </div>
                </section>

                <!-- Section 2: Payment -->
                <section class="glass rounded-[2.5rem] p-8 shadow-2xl transition-all hover:shadow-indigo-500/5">
                    <div class="flex items-center justify-between mb-8">
                        <h2 class="text-3xl font-black text-slate-900 tracking-tight flex items-center">
                            <span class="bg-indigo-600 text-white w-10 h-10 rounded-2xl flex items-center justify-center mr-4 text-lg shadow-lg shadow-indigo-200">2</span>
                            Payment Method
                        </h2>
                        <button onclick="document.getElementById('addCardModal').classList.remove('hidden')" 
                                class="text-indigo-600 hover:text-indigo-700 font-bold text-sm flex items-center transition-all hover:translate-x-1">
                            <i class="fas fa-plus-circle mr-2"></i> Add New
                        </button>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <c:forEach items="${cards}" var="card">
                            <label class="group relative block cursor-pointer transition-all duration-300">
                                <input type="radio" name="selectedCard" value="${card.cardId}" ${card.defaultCard ? 'checked' : ''} class="hidden peer">
                                
                                <div class="relative overflow-hidden p-6 rounded-[2rem] bg-white border-2 border-slate-100 shadow-sm transition-all duration-300 
                                            peer-checked:border-indigo-600 peer-checked:shadow-2xl peer-checked:shadow-indigo-100 peer-checked:bg-indigo-50/10
                                            group-hover:border-indigo-200 group-hover:shadow-lg">
                                    
                                    <div class="flex justify-between items-start mb-6">
                                        <div class="w-12 h-8 bg-slate-50 rounded flex items-center justify-center border border-slate-100">
                                            <c:choose>
                                                <c:when test="${card.cardType == 'Visa'}"><i class="fab fa-cc-visa text-2xl text-blue-800"></i></c:when>
                                                <c:when test="${card.cardType == 'MasterCard'}"><i class="fab fa-cc-mastercard text-2xl text-red-500"></i></c:when>
                                                <c:otherwise><i class="fas fa-credit-card text-2xl text-slate-300"></i></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <c:if test="${card.defaultCard}">
                                            <span class="bg-indigo-600 text-white text-[9px] font-black uppercase tracking-tighter px-2 py-0.5 rounded-lg shadow-sm">Primary</span>
                                        </c:if>
                                        <div class="w-6 h-6 rounded-full border-2 border-slate-200 peer-checked:border-indigo-600 flex items-center justify-center transition-all bg-white
                                                    peer-checked:after:content-[''] peer-checked:after:w-3 peer-checked:after:h-3 peer-checked:after:bg-indigo-600 peer-checked:after:rounded-full">
                                            <div class="w-3 h-3 bg-indigo-600 rounded-full scale-0 peer-checked:scale-100 transition-transform"></div>
                                        </div>
                                    </div>

                                    <div class="space-y-1">
                                        <p class="text-sm font-bold text-slate-800 tracking-widest italic">•••• •••• •••• ${card.cardNumberLast4}</p>
                                        <p class="text-[10px] font-black text-slate-400 uppercase tracking-widest">${card.cardholderName}</p>
                                    </div>
                                    
                                    <div class="mt-4 pt-4 border-t border-slate-50 flex justify-between items-center">
                                        <span class="text-[10px] font-bold text-slate-400 uppercase">Exp: ${card.expiryMonth}/${card.expiryYear}</span>
                                        <i class="fas fa-check-circle text-indigo-600 scale-0 peer-checked:scale-100 transition-transform"></i>
                                    </div>
                                </div>
                            </label>
                        </c:forEach>
                        
                        <!-- Empty State for Cards -->
                        <c:if test="${empty cards}">
                            <div class="md:col-span-2 p-10 text-center border-2 border-dashed border-slate-200 rounded-[2rem] bg-white/40">
                                <i class="fas fa-credit-card text-4xl text-slate-200 mb-4"></i>
                                <p class="text-slate-500 font-bold">No payment cards found</p>
                                <p class="text-slate-400 text-xs mt-1">Please add a card to proceed with your order</p>
                            </div>
                        </c:if>
                    </div>
                </section>
            </div>

            <!-- Right Side: Total & Action (4 cols) -->
            <div class="lg:col-span-4">
                <div class="sticky top-32">
                    <div class="glass rounded-[2.5rem] p-8 shadow-2xl shadow-indigo-500/10 border border-white/60">
                        <h3 class="text-2xl font-black text-slate-900 mb-8 tracking-tight">Order Summary</h3>
                        
                        <div class="space-y-4 mb-8">
                            <div class="flex justify-between items-center text-sm font-medium">
                                <span class="text-slate-400 uppercase tracking-widest text-[10px] font-black">Subtotal</span>
                                <span class="text-slate-900 font-bold">$${product.price * quantity}</span>
                            </div>
                            <div class="flex justify-between items-center text-sm font-medium">
                                <span class="text-slate-400 uppercase tracking-widest text-[10px] font-black">Shipping</span>
                                <span class="text-emerald-500 font-black">FREE</span>
                            </div>
                            <div class="flex justify-between items-center text-sm font-medium">
                                <span class="text-slate-400 uppercase tracking-widest text-[10px] font-black">Estimated Tax</span>
                                <span class="text-slate-900 font-bold">$0.00</span>
                            </div>
                            <div class="pt-6 mt-6 border-t border-slate-100">
                                <div class="flex justify-between items-end">
                                    <span class="text-slate-900 font-black text-lg tracking-tight">Total</span>
                                    <div class="text-right">
                                        <p class="text-4xl font-black text-indigo-600 leading-none">$${product.price * quantity}</p>
                                        <p class="text-[9px] font-black text-slate-400 uppercase tracking-tighter mt-2">USD inclusive of taxes</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <form action="${pageContext.request.contextPath}/user/order" method="POST" id="checkoutForm">
                            <input type="hidden" name="action" value="confirm">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <input type="hidden" name="quantity" value="${quantity}">
                            <input type="hidden" name="cardId" id="finalCardId" value="">
                            
                            <button type="submit" onclick="return validatePayment()" 
                                    class="neo-button w-full py-5 text-white rounded-2xl font-black text-lg transition-all active:scale-95 group">
                                <span class="flex items-center justify-center">
                                    Complete Purchase
                                    <i class="fas fa-arrow-right ml-3 group-hover:translate-x-2 transition-transform"></i>
                                </span>
                            </button>
                        </form>

                        <div class="mt-8 p-4 bg-slate-50/50 rounded-2xl border border-slate-100">
                            <div class="flex items-center text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">
                                <i class="fas fa-shield-alt text-indigo-400 mr-2"></i> Buyer Protection
                            </div>
                            <p class="text-[10px] leading-relaxed text-slate-400 font-medium">
                                Your information is protected by 256-bit SSL encryption. 
                                By clicking the button above, you agree to our terms of service.
                            </p>
                        </div>
                    </div>

                    <!-- Trust Badges -->
                    <div class="mt-8 flex justify-center gap-6 opacity-30 grayscale hover:grayscale-0 hover:opacity-100 transition-all duration-700">
                        <i class="fab fa-cc-visa text-3xl"></i>
                        <i class="fab fa-cc-mastercard text-3xl"></i>
                        <i class="fab fa-cc-apple-pay text-3xl"></i>
                        <i class="fab fa-cc-amazon-pay text-3xl"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Card Modal -->
    <div id="addCardModal" class="hidden fixed inset-0 bg-slate-900/40 backdrop-blur-md z-[2000] flex items-center justify-center p-5">
        <div class="bg-white rounded-[3rem] shadow-2xl w-full max-w-lg p-10 relative animate-in fade-in zoom-in duration-300 border border-white/20">
            <button onclick="document.getElementById('addCardModal').classList.add('hidden')" 
                    class="absolute top-8 right-8 text-slate-400 hover:text-slate-900 transition-colors">
                <i class="fas fa-times text-2xl"></i>
            </button>
            
            <div class="mb-10">
                <h2 class="text-3xl font-black text-slate-900 tracking-tight">New Payment Card</h2>
                <p class="text-slate-500 font-medium mt-2">Securely add a new card to your account</p>
            </div>
            
            <form action="${pageContext.request.contextPath}/user/payment-cards" method="POST" class="space-y-6">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/user/order?productId=${product.productId}&quantity=${quantity}">
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="md:col-span-2">
                        <label class="block text-xs font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Cardholder Name</label>
                        <input type="text" name="cardholderName" required placeholder="John Doe"
                               class="w-full p-4 bg-slate-50 border border-slate-100 rounded-2xl focus:ring-4 focus:ring-indigo-100 focus:border-indigo-600 outline-none transition-all font-bold text-slate-800">
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-xs font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Card Number</label>
                        <div class="relative">
                            <input type="text" name="cardNumber" maxlength="16" required placeholder="0000 0000 0000 0000" 
                                   class="w-full p-4 bg-slate-50 border border-slate-100 rounded-2xl focus:ring-4 focus:ring-indigo-100 focus:border-indigo-600 outline-none transition-all font-bold text-slate-800 tracking-widest">
                            <i class="fas fa-credit-card absolute right-4 top-1/2 -translate-y-1/2 text-slate-300 text-xl"></i>
                        </div>
                    </div>
                    <div>
                        <label class="block text-xs font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Expiry Month</label>
                        <select name="expiryMonth" id="expiryMonth" class="w-full p-4 bg-slate-50 border border-slate-100 rounded-2xl outline-none focus:ring-4 focus:ring-indigo-100 font-bold text-slate-800">
                            <c:forEach var="i" begin="1" end="12">
                                <option value="${i}">${i < 10 ? '0' : ''}${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Expiry Year</label>
                        <input type="number" name="expiryYear" id="expiryYear" value="2026" min="2026" 
                               class="w-full p-4 bg-slate-50 border border-slate-100 rounded-2xl outline-none focus:ring-4 focus:ring-indigo-100 font-bold text-slate-800">
                    </div>
                    <div class="md:col-span-2">
                        <label class="block text-xs font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Card Network</label>
                        <div class="grid grid-cols-3 gap-4">
                            <label class="cursor-pointer">
                                <input type="radio" name="cardType" value="Visa" checked class="hidden peer">
                                <div class="p-3 text-center rounded-xl bg-slate-50 border border-slate-100 peer-checked:border-indigo-600 peer-checked:bg-indigo-50 transition-all font-bold text-xs text-slate-400 peer-checked:text-indigo-600">
                                    Visa
                                </div>
                            </label>
                            <label class="cursor-pointer">
                                <input type="radio" name="cardType" value="MasterCard" class="hidden peer">
                                <div class="p-3 text-center rounded-xl bg-slate-50 border border-slate-100 peer-checked:border-indigo-600 peer-checked:bg-indigo-50 transition-all font-bold text-xs text-slate-400 peer-checked:text-indigo-600">
                                    MasterCard
                                </div>
                            </label>
                            <label class="cursor-pointer">
                                <input type="radio" name="cardType" value="Amex" class="hidden peer">
                                <div class="p-3 text-center rounded-xl bg-slate-50 border border-slate-100 peer-checked:border-indigo-600 peer-checked:bg-indigo-50 transition-all font-bold text-xs text-slate-400 peer-checked:text-indigo-600">
                                    Amex
                                </div>
                            </label>
                        </div>
                    </div>
                </div>
                
                <div class="flex items-center pt-2">
                    <label class="relative inline-flex items-center cursor-pointer">
                        <input type="checkbox" name="isDefault" id="isDefault" class="sr-only peer">
                        <div class="w-11 h-6 bg-slate-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-indigo-100 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-indigo-600"></div>
                        <span class="ml-3 text-sm font-bold text-slate-500">Set as primary method</span>
                    </label>
                </div>
                
                <button type="submit" onclick="return validateNewCard()" class="neo-button w-full py-4 text-white rounded-[1.5rem] font-black text-lg shadow-xl mt-6 transition-all active:scale-95">
                    Save and Continue
                </button>
            </form>
        </div>
    </div>
</main>

<script>
    function validateNewCard() {
        const monthSelect = document.getElementById('expiryMonth');
        const yearInput = document.getElementById('expiryYear');
        if (!monthSelect || !yearInput) return true;
        
        const month = parseInt(monthSelect.value);
        const year = parseInt(yearInput.value);
        if (year < 2026 || (year === 2026 && month <= 4)) {
            alert('Expiry date must be after April 2026.');
            return false;
        }
        return true;
    }

    function validatePayment() {
        const selected = document.querySelector('input[name="selectedCard"]:checked');
        if (!selected) {
            alert('Please select a payment card or add a new one.');
            return false;
        }
        document.getElementById('finalCardId').value = selected.value;
        return true;
    }
</script>

<%@ include file="../partials/UserFooter.jsp" %>
