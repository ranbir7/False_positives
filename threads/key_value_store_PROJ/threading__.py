import threading

# Initialize semaphores
sem_a = threading.Semaphore(0)  # Blocked initially
sem_b = threading.Semaphore(0)  # Blocked initially

def thread_a():
    print("8 Thread A: Executing a1")
    sem_b.release()  # Allow Thread B to proceed to b2
    print("10 Thread A: Released Thread B to execute b2")
    sem_a.acquire()  # Wait for signal from Thread B
    print("12 Thread A: Executing a2")

def thread_b():
    print("15 Thread B: Executing b1")
    sem_a.release()  # Allow Thread A to proceed to a2
    print("17 Thread B: Released Thread A to execute a2")
    sem_b.acquire()  # Wait for signal from Thread A
    print("19 Thread B: Executing b2")

# Create threads
print("22 Creating threads...")

t1 = threading.Thread(target=thread_a)
t2 = threading.Thread(target=thread_b)

# Start threads
print("28 Starting threads...")
t1.start()
print("30 Thread A started")
t2.start()
print("32 Thread B started")

# Wait for both threads to complete
print("35 Waiting for threads to complete...")
t2.join()
t1.join()
print("Threads completed.")
