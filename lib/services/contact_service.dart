import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../core/network/dio_client.dart';
import '../models/contact_model.dart';

class ContactService {
  final Dio _dio = DioClient().dio;

  Future<List<ContactModel>> getContacts() async {
    try {
      final response = await _dio.get(ApiConstants.contactsEndpoint);
      final List<dynamic> data = response.data;
      return data.map((json) => ContactModel.fromMap(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ContactModel> getContactById(String id) async {
    try {
      final response = await _dio.get('${ApiConstants.contactsEndpoint}/$id');
      return ContactModel.fromMap(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ContactModel> addContact(ContactModel contact) async {
    try {
      final response = await _dio.post(
        ApiConstants.contactsEndpoint,
        data: contact.toMap(),
      );
      return ContactModel.fromMap(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ContactModel> updateContact(String id, ContactModel contact) async {
    try {
      final response = await _dio.put(
        '${ApiConstants.contactsEndpoint}/$id',
        data: contact.toMap(),
      );
      return ContactModel.fromMap(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      await _dio.delete('${ApiConstants.contactsEndpoint}/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response?.statusCode);
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}