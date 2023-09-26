class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230926"
    checksums = {
        "darwin_arm64" => "0d70c527f7cf1fa28b2d6f43e8aeb57548838bdf9f5df9e43dbb9c5b75b5208f",
        "darwin_amd64" => "ed73affb6d8e2329c06bf9c8a9cfe0b5928d3686e6383cf19c6e77da77902733",
        "linux_arm64"  => "7b16b4bb7a31fd05076e1d5ee2456e3e92ff988d5ca8830656abc14b8bb0ba7b",
        "linux_amd64"  => "dd21277b7bd3bb2d4b9ea7e7afea5fa1890c26a8f1f51cc059a1589068b37b17",
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
