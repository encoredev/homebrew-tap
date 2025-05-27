class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.1"
    checksums = {
        "darwin_arm64" => "abff75bb8cb29fe2481180472216fb9ff28d3a3e0e3d151a18f7d9d3603cd98e",
        "darwin_amd64" => "c99445cd17431209ae17c694ea0e316aff62229d46c504d58616fc66a920a527",
        "linux_arm64"  => "22b9cbadf52e02aeb8c97b63ecf32d028ef896bfc09578ca07edfce16482ed93",
        "linux_amd64"  => "f56c16d644e7e0b8f658e3af4b7a4ca3771739924145fa64e1bb57259824ae18",
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
