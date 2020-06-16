<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>
<style>
    .custab {
        margin: 0;
    }

    .container {
        margin-top: 50px;
    }

</style>
<div class="row">
    <div class="container">
        <div class="content-center">

            <h2> 차별화된 주가 예측 시스템</h2>

            <P class="text-center">기존의 주가예측보다 주식별 상관성을 더한 예측으로 약 10% 향상된 예측율</P>
            <P class="text-center"> (예상 수익률 40% 정확도 60%)</P>
            <div class="button">
                <input type="button" class="btn btn-primary" value="View Developer Process"
                       onclick="location.href='devpro'"/><br/>
            </div>
            <h2>TOP 5 Hot Stocks Today </h2>
            <table class="table table-striped custab">
                <thead>
                <tr>
                    <th class="text-center">주식명</th>
                    <th class="text-center">금일종가</th>
                    <th class="text-center">명일예측</th>
                    <th class="text-center">등락적중률</th>
                    <th class="text-center" title="최근 3개월 기준으로 투자를 진행한 경우">*최근3개월수익율</th>
                    <th class="text-center">평균오차범위</th>
                </tr>
                </thead>
                <c:forEach items="${list}" var="item">
                    <tbody>
                    <tr>
                        <td style="cursor:pointer;" class="text-center text-primary" width="165"
<%--                            onClick=" location.href='/get?name=<c:out value="${item.com_name}"/>'">--%>
                            onClick=" location.href='/get?code=<c:out value="${item.com_code}"/>'">
                            <c:out value="${item.com_name}"/>
                        </td>
                            <%--r종가--%>
                        <c:if test="${item.tod_status < 0}">

                            <td class="text-center" width="165">
                                <fmt:formatNumber value="${item.tod_price}"/> <span class="triangle test_1"></span>

                            </td>
                        </c:if>
                        <c:if test="${item.tod_status > 0}">
                            <td class="text-center" width="165">
                                <fmt:formatNumber value="${item.tod_price}"/> <span class="triangle test_2"></span>

                            </td>
                        </c:if>
                        <c:if test="${item.tod_status == 0}">
                            <td class="text-center" width="165">
                                <fmt:formatNumber value="${item.tod_price}"/>
                            </td>
                        </c:if>
                        <c:if test="${item.tom_status < 0}">
                            <td class="text-center" width="165">
                                <fmt:formatNumber value="${item.tom_price}"/><span class="bh-font-12size">(<c:out
                                    value="${item.next_day_return}"/>%)</span><span
                                    class="triangle test_1"></span>
                            </td>
                        </c:if>
                        <c:if test="${item.tom_status > 0}">
                            <td class="text-center" width="165">
                                <fmt:formatNumber value="${item.tom_price}"/><span class="bh-font-12size">(<c:out
                                    value="${item.next_day_return}"/>%)</span><span
                                    class="triangle test_2"> </span>
                            </td>
                        </c:if>
                        <c:if test="${item.tom_status == 0}">
                            <td class="text-center" width="165">
                                <fmt:formatNumber value="${item.tom_price}"/><span class="bh-font-12size">(<c:out
                                    value="${item.next_day_return}"/>%)</span>
                            </td>
                        </c:if>

                            <%-- 등락적중률--%>
                        <td class="text-center" width="165">
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0"
                                     aria-valuemax="100"
                                     style="width:<c:out value="${item.mean_match_status*100}"/>%;">
                                    <fmt:formatNumber value="${item.mean_match_status*100}"/>%
                                </div>
                            </div>
                        </td>
                            <%--최근한달수익율--%>
                        <c:if test="${item.tod_return > 1}">
                            <td class="text-center" width="165" style="word-break:break-all">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="60"
                                         aria-valuemin="0"
                                         aria-valuemax="100" style="width:<c:out value="${item.tod_return*40}"/>%;">
                                        <fmt:formatNumber value="${item.tod_return*100-100}"/>%
                                    </div>
                                </div>
                            </td>
                        </c:if>
                        <c:if test="${item.tod_return < 1}">
                            <td class="text-center" width="165" style="word-break:break-all">
                                <div class="progress">
                                    <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="60"
                                         aria-valuemin="0"
                                         aria-valuemax="100" style="width:<c:out value="${item.tod_return*40}"/>%;">
                                        <fmt:formatNumber value="${item.tod_return*100-100}"/>%
                                    </div>
                                </div>
                            </td>
                        </c:if>
                        <td class="text-center" style="word-break:break-all" width="165">
                            <c:out value="${item.mean_price_error}"/>%
                        </td>
                    </tr>
                    </tbody>
                </c:forEach>
            </table>
            <button type="button" class="btn btn-primary  pull-right" onclick="location.href='view'">전체리스트보기
            </button>
        </div>
    </div>
</div>
