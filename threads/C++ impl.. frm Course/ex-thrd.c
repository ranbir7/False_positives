#include <stdio.h>
#include <stdlib.h>
#include <pthread.h> /* For working with POSIX threads */
#include <unistd.h>  /* For pause() and sleep() */

/* Thread callback function */
static void *thread_fn_callback(void *arg)
{
    char *input = (char *)arg;
    // printf("%s is running\n", input);

    while (1)
    {

        printf(" and  input string is = %s \n", input);
        sleep(1); // Sleep for 1 second
    }
}

void thread1_create()
{
    pthread_t pthread1;
    static char *thread1_name = "wtf Thread 1";
    int rc = pthread_create(&pthread1,
                            NULL,
                            thread_fn_callback,
                            (void *)thread1_name);

    if (rc != 0)
    {
        printf("Error creating thread 1\n");
        exit(0);
    }
}

int main(int argc, char **argv)
{
    thread1_create();
    printf("main fn paused\n");
    getchar(); // Wait for user input to continue
    return 0;
}
