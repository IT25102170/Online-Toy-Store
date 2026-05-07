<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../partials/UserHeader.jsp" %>

<main class="min-h-screen pt-24 pb-12 px-5 bg-gradient-to-br from-blue-50 to-indigo-100">
    <div class="max-w-5xl mx-auto">
        
        <!-- Header Section -->
        <div class="flex justify-between items-end mb-12">
            <div>
                <h1 class="text-4xl font-black text-gray-900">Payment Methods</h1>
                <p class="text-gray-500 font-medium mt-2">Manage your saved cards for a faster checkout experience</p>
            </div>
            <a href="${pageContext.request.contextPath}/user/payment-cards?mode=add" 
               class="px-8 py-4 bg-indigo-600 text-white rounded-2xl font-bold shadow-lg hover:bg-indigo-700 hover:-translate-y-1 transition-all flex items-center">
                <i class="fas fa-plus mr-2"></i> Add New Card
            </a>
        </div>

        <!-- Feedback Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="bg-green-50 border border-green-100 text-green-700 px-6 py-4 rounded-2xl mb-8 flex items-center animate-in slide-in-from-top">
                <i class="fas fa-check-circle mr-3"></i>
                <p class="font-bold">${sessionScope.success}</p>
                <c:remove var="success" scope="session"/>
            </div>
        </c:if>

        <!-- LIST Mode -->
        <c:if test="${mode == 'list'}">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach items="${cards}" var="card">
                    <div class="relative group">
                        <div class="bg-white rounded-[2rem] p-8 shadow-xl border border-white/20 backdrop-blur-lg hover:shadow-2xl transition-all h-full flex flex-col justify-between">
                            <div>
                                <div class="flex justify-between items-start mb-8">
                                    <div class="w-14 h-10 bg-gray-50 rounded-lg flex items-center justify-center border border-gray-100">
                                        <c:choose>
                                            <c:when test="${card.cardType == 'Visa'}"><i class="fab fa-cc-visa text-2xl text-blue-800"></i></c:when>
                                            <c:when test="${card.cardType == 'MasterCard'}"><i class="fab fa-cc-mastercard text-2xl text-red-500"></i></c:when>
                                            <c:otherwise><i class="fas fa-credit-card text-2xl text-gray-400"></i></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <c:if test="${card.defaultCard}">
                                        <span class="bg-indigo-50 text-indigo-600 text-[10px] font-black uppercase tracking-widest px-3 py-1 rounded-full">Default</span>
                                    </c:if>
                                </div>
                                <h3 class="text-xl font-bold text-gray-800 tracking-widest mb-1">•••• •••• •••• ${card.cardNumberLast4}</h3>
                                <p class="text-xs text-gray-400 font-bold uppercase tracking-tighter mb-4">${card.cardType} Card</p>
                                
                                <div class="flex justify-between mt-6">
                                    <div>
                                        <p class="text-[10px] text-gray-400 font-black uppercase tracking-widest">Card Holder</p>
                                        <p class="text-sm font-bold text-gray-800 uppercase">${card.cardholderName}</p>
                                    </div>
                                    <div class="text-right">
                                        <p class="text-[10px] text-gray-400 font-black uppercase tracking-widest">Expires</p>
                                        <p class="text-sm font-bold text-gray-800">${card.expiryMonth}/${card.expiryYear}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-8 pt-6 border-t border-gray-50 flex justify-end space-x-4">
                                <a href="${pageContext.request.contextPath}/user/payment-cards?mode=edit&cardId=${card.cardId}" 
                                   class="text-indigo-600 font-bold text-sm hover:text-indigo-800">Edit</a>
                                <form action="${pageContext.request.contextPath}/user/payment-cards" method="POST" onsubmit="return confirm('Remove this card?');">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="cardId" value="${card.cardId}"/>
                                    <button type="submit" class="text-red-400 font-bold text-sm hover:text-red-600">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty cards}">
                <div class="bg-white/50 rounded-[3rem] p-20 text-center border-2 border-dashed border-gray-200">
                    <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center mx-auto mb-6 shadow-sm text-gray-300 text-3xl">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <h3 class="text-2xl font-black text-gray-800">No cards saved</h3>
                    <p class="text-gray-500 mt-2 max-w-xs mx-auto">Add a payment method to enjoy a seamless shopping experience.</p>
                </div>
            </c:if>
        </c:if>

        <!-- ADD / EDIT Mode -->
        <c:if test="${mode == 'add' || mode == 'edit'}">
            <div class="max-w-2xl mx-auto">
                <div class="bg-white rounded-[2.5rem] shadow-2xl p-12 border border-white/20 backdrop-blur-xl">
                    <h2 class="text-3xl font-black text-gray-900 mb-8">
                        ${mode == 'add' ? 'Add New Card' : 'Update Card Info'}
                    </h2>

                    <form action="${pageContext.request.contextPath}/user/payment-cards" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="${mode == 'add' ? 'add' : 'update'}"/>
                        <c:if test="${mode == 'edit'}">
                            <input type="hidden" name="cardId" value="${currentCard.cardId}"/>
                        </c:if>

                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">Cardholder Name</label>
                            <input type="text" name="cardholderName" required class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all"
                                   value="${mode == 'edit' ? currentCard.cardholderName : ''}">
                        </div>

                        <c:if test="${mode == 'add'}">
                            <div>
                                <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">Card Number</label>
                                <input type="text" name="cardNumber" required maxlength="16" placeholder="XXXX XXXX XXXX XXXX"
                                       class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                            </div>
                        </c:if>

                        <div class="grid grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">Card Type</label>
                                <select name="cardType" required class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl outline-none focus:ring-2 focus:ring-indigo-500 transition-all">
                                    <option value="Visa" ${mode == 'edit' && currentCard.cardType == 'Visa' ? 'selected' : ''}>Visa</option>
                                    <option value="MasterCard" ${mode == 'edit' && currentCard.cardType == 'MasterCard' ? 'selected' : ''}>MasterCard</option>
                                    <option value="Amex" ${mode == 'edit' && currentCard.cardType == 'Amex' ? 'selected' : ''}>Amex</option>
                                </select>
                            </div>
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">Exp Month</label>
                                    <input type="number" name="expiryMonth" id="expiryMonth" min="1" max="12" required
                                           class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl outline-none focus:ring-2 focus:ring-indigo-500 transition-all"
                                           value="${mode == 'edit' ? currentCard.expiryMonth : ''}">
                                </div>
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">Exp Year</label>
                                    <input type="number" name="expiryYear" id="expiryYear" min="2026" required
                                           class="w-full p-4 bg-gray-50 border border-gray-100 rounded-2xl outline-none focus:ring-2 focus:ring-indigo-500 transition-all"
                                           value="${mode == 'edit' ? currentCard.expiryYear : '2026'}">
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center p-4 bg-indigo-50 rounded-2xl">
                            <input type="checkbox" name="isDefault" id="isDefault" ${mode == 'edit' && currentCard.defaultCard ? 'checked' : ''} class="w-5 h-5 text-indigo-600 rounded">
                            <label for="isDefault" class="ml-3 text-sm font-bold text-indigo-900">Set as my default payment method</label>
                        </div>

                        <div class="flex space-x-4 pt-4">
                            <button type="submit" onclick="return validateCardForm()" class="flex-1 py-4 bg-indigo-600 text-white rounded-2xl font-bold shadow-lg hover:bg-indigo-700 transition-all">
                                ${mode == 'add' ? 'Save Card' : 'Update Card'}
                            </button>
                            <a href="${pageContext.request.contextPath}/user/payment-cards" 
                               class="flex-1 py-4 bg-gray-50 text-gray-600 rounded-2xl font-bold text-center border border-gray-100 hover:bg-gray-100 transition-all">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

    </div>
</main>

<%@ include file="../partials/UserFooter.jsp" %>

<script>
    function validateCardForm() {
        const monthInput = document.getElementById('expiryMonth');
        const yearInput = document.getElementById('expiryYear');
        if (!monthInput || !yearInput) return true;

        const month = parseInt(monthInput.value);
        const year = parseInt(yearInput.value);
        if (year < 2026 || (year === 2026 && month <= 4)) {
            alert('Expiry date must be after April 2026.');
            return false;
        }
        return true;
    }
</script>
