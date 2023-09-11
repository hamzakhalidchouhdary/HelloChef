import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  private productUrl = 'http://127.0.0.1:4100/api/v1/item?shop_id=1';

  constructor(private httpClient: HttpClient) { }

  fetchProducts(): Observable<any> {
    const token = `Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJyb2xlIjpudWxsfQ.tA1WN3SDRxjwfq08j2VjzWJnSPU8kLnvnN6jGfZSxaY`
    const header = new HttpHeaders({
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
}
