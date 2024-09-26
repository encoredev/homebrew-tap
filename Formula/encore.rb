class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.6"
    checksums = {
        "darwin_arm64" => "a06a8ddf604cc5936749be06443d5f8c95862f523c17286ed4e4511f7c961b48",
        "darwin_amd64" => "64efde08947e340aa1604ef824a3c97f559d7c234a6c3b4cf4c8480884cd4117",
        "linux_arm64"  => "8a6ee2e1cc4507997f5fe30e88186604cbfffaf60807675aaa0993072ebecd08",
        "linux_amd64"  => "60572fea911069733364726172545381096aad50b205d5e937cfac8822b530a2",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
