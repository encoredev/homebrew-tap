class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.7"
    checksums = {
        "darwin_arm64" => "605ab5d1d1d94d539930e2868f6a98022b4049a78dda41e69a9b4791b73bcaaa",
        "darwin_amd64" => "8335c65f4de727f485bfd671c96045fc395340abeb6a3b9315bd5db92fadc691",
        "linux_arm64"  => "d4d3dc344051639eca8f6c9b59e0fd6470d2c0fa5718fd8cc54d5cf787f1eef3",
        "linux_amd64"  => "74bfba2d616f7c9d875ec10cc36df519353c755fec51a9de23d5d3daa4bdd249",
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
