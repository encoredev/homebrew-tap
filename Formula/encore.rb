class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.46.11"
    checksums = {
        "darwin_arm64" => "9c575e2520e46bf7109e0a2b04f1f0a44c9bf1612c4329313e64814525d28ed3",
        "darwin_amd64" => "16fc03a5d5ca7fea9390a9e34999f0a44e546ff95425751219f44d9dee2fa84e",
        "linux_arm64"  => "24bb6c01c9d3c0b551de42f3f0692b3e6a7630f6b5bac8887b180211eee86759",
        "linux_amd64"  => "8a5ecc82f10f83e074b6d3864cf3967c97bbac6906b5153eaa6af93876be1c6c",
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
