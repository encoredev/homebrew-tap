class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.47.1"
    checksums = {
        "darwin_arm64" => "98153fcc5e5c9a35c8a341b54af1afef2970539cb1be3133e472d9e392398993",
        "darwin_amd64" => "78a3f5d0564ff50e20cbcc976b7b0c73fad2898e5b81bff8e6f3c7de219bfe59",
        "linux_arm64"  => "272e6188572deb3f3e4198f44f1779c68434c90f7c7c4ae60c992a0b37bfcf34",
        "linux_amd64"  => "ae881033099bab2fd9dc02c902ab1b12644d371c0e2e48f3807dc7f6db06a32e",
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
