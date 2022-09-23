STLDIR=stl
DEPDIR=deps
SOURCES=negative positive lock
CLEANOBJS=$(DEPDIR) $(STLDIR)

all: dirs $(patsubst %,$(STLDIR)/%.stl,$(SOURCES))

$(STLDIR)/%.stl: %.scad
	openscad -o $@ $< -d $(DEPDIR)/$*.d

clean:
	rm -rf $(CLEANOBJS)

dirs: 
	mkdir -p $(STLDIR) $(DEPDIR)

-include $(DEPDIR)/negative.d
-include $(DEPDIR)/positive.d
-include $(DEPDIR)/lock.d
