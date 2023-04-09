/*

int xem_init(xem_t *xem){
	xem->value = 1;
	xem->guard = 0;
	for(int i=0; i<NPROC; i++){
		xem->queue[i] = 0;
	}
	xem->front = 0;
	xem->rear = 0;
	return 0;
}

int xem_wait(xem_t* xem){
	while(TestAndSet(&xem->gurard, 1) == 1)
		;
	if(xem->value > 0){
		xem->value--;
		xem->guard = 0;
	}else{ //xem->value == 0
		xem->queue[xem->rear++ &NPROC] = curproc->pid; //pid -> queue
		xem->guard = 0;
		sleep(curproc->pid, &ptable.lock);
	}
	return xem->value;
}

int xem_unlock(xem_t* zem){
	while(TestAndSet(&xem->guard, 1) == 1) //only if xem->guard 0, function change xem->value.
		;
	if(xem->rear == xem->front) //queue empty
		xem->value = 1;
	else //queue not empty, xem->value == 0
		wakeup(xem->queue[xem->front++ %NPROC]);
	return xem->value;
}
*/
