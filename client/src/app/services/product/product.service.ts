import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  private productUrl = 'http://127.0.0.1:4100/api/v1/item?shop_id=1';

  constructor(private httpClient: HttpClient) { }

  fetchProducts(): Observable<any> {
    const token: string = environment.userToken || '';
    const header: HttpHeaders = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': token
    })
    return this.httpClient
      .get<any>(this.productUrl, {headers: header})
      .pipe(catchError((error: any) => {
        return throwError(() => {
          let err = new Error('error in fetching products');
          err.message = error.error.error;
          return err;
        });
      })
    );
  }
  saveProduct(payload: any): Observable<any> {
    const token: string = environment.userToken || '';
    const header: HttpHeaders = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': token
    })
    return this.httpClient
      .put<any>(`http://127.0.0.1:4100/api/v1/item/${payload.id}`,payload, {headers: header})
      .pipe(catchError((error: any) => {
        return throwError(() => {
          let err = new Error('error in saving products');
          err.message = error.error.error;
          return err;
        });
      })
    );
  }
  createProduct(payload: any): Observable<any> {
    const token: string = environment.userToken || '';
    const header: HttpHeaders = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': token
    })
    payload.shop_id = 1;
    payload.created_by_id = 1;
    payload.updated_by_id = 1;
    return this.httpClient
      .post<any>(`http://127.0.0.1:4100/api/v1/item/`,payload, {headers: header})
      .pipe(catchError((error: any) => {
        return throwError(() => {
          let err = new Error('error in saving products');
          err.message = error.error.error;
          return err;
        });
      })
    );
  }
  removeProduct(id: Number): Observable<any> {
    const token: string = environment.userToken || '';
    const header: HttpHeaders = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': token
    })
    return this.httpClient
      .delete<any>(`http://127.0.0.1:4100/api/v1/item/${id}?shop_id=1`, {headers: header})
      .pipe(catchError((error: any) => {
        return throwError(() => {
          let err = new Error('error in saving products');
          err.message = error.error.error;
          return err;
        });
      })
    );
  }
}
